import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/utils/time.dart';
import 'package:intl/intl.dart';
import 'dart:developer' show log;

class DatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Dummy data for demo purpose
  static const String _user = "user1";

  static List<String> weekdays = ["Sn", "M", "T", "W", "Th", "F", "S"];
  static const weekdaysLen = 7;
  static List<int> weekIndices = List.generate(weekdaysLen, (index) => index);

  static Future<List<Routine>> getRoutines() async {
    final DocumentReference userRef = _db.collection("users").doc(_user);

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await userRef.collection("routines").get();

    return snapshot.docs
        .map((docSnapshot) => Routine.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  static Stream<List<DayRoutine>> getDayRoutines(DateTime date) async* {
    List<Routine> routines = await getRoutines();
    String day = DateFormat.yMd().format(date);
    List<DayRoutine> dayRoutines = [];
    CollectionReference collectionRef;
    QuerySnapshot docs;
    double completionRate;

    for (Routine routine in routines) {
      collectionRef = routine.docRef!.collection("completedActivities");

      docs = await collectionRef.where("date", isEqualTo: day).get();

      completionRate = (docs.size / (routine.numActivities).toDouble()) * 100;

      dayRoutines.add(DayRoutine(
          name: routine.name,
          icon: routine.icon,
          color: routine.color,
          numActivities: routine.numActivities,
          completionRate: completionRate));
    }

    yield dayRoutines;
  }

  static Future<List<RoutineAverage>> getDailyAvgCompletionRate(
      DateTime date) async {
    List<Routine> routines = await getRoutines();
    List<RoutineAverage> dailyAvgCompletionRate = [];
    DateTime startDay = Time.getWeekStart(date);
    dynamic day;

    CollectionReference collectionRef;
    QuerySnapshot docs;
    double totalNumActs;
    double totalDoneActs;
    double completionRate;

    for (int i in weekIndices) {
      totalNumActs = 0;
      totalDoneActs = 0;

      day = Time.addDays(startDay, i);
      day = DateFormat.yMd().format(day);

      for (Routine routine in routines) {
        collectionRef = routine.docRef!.collection("completedActivities");
        docs = await collectionRef.where("date", isEqualTo: day).get();

        totalDoneActs += docs.size;
        totalNumActs += routine.numActivities;
      }

      completionRate = (totalDoneActs / totalNumActs) * 100;

      dailyAvgCompletionRate.add(RoutineAverage(weekdays[i], completionRate));
    }

    double totalRates = 0;
    double rate;

    for (final day in dailyAvgCompletionRate) {
      rate = day.completionRate;
      if (rate != 0) {
        totalRates += rate;
      }
    }

    if (totalRates == 0) {
      return [];
    }

    return dailyAvgCompletionRate;
  }

  static Future<List<DayRoutine>> getWeeklyAverageCompletionRate(
      DateTime date) async {
    List<Routine> routines = await getRoutines();
    List<DayRoutine> weeklyAvgCompletionRate = [];
    DateTime startDay = Time.getWeekStart(date);
    DateTime endDay = startDay.add(const Duration(days: 6));
    String startDate = DateFormat.yMd().format(startDay);
    String endDate = DateFormat.yMd().format(endDay);
    double completionRate;
    CollectionReference collectionRef;
    QuerySnapshot docs;

    for (Routine routine in routines) {
      collectionRef = routine.docRef!.collection("completedActivities");
      docs = await collectionRef
          .where("date", isGreaterThanOrEqualTo: startDate)
          .where("date", isLessThanOrEqualTo: endDate)
          .get();

      completionRate = (docs.size /
              (routine.numActivities.toDouble() *
                  routine.repeatDaysCount!.toDouble())) *
          100;

      weeklyAvgCompletionRate.add(
        DayRoutine(
            name: routine.name,
            color: routine.color,
            icon: routine.icon,
            numActivities: routine.numActivities,
            completionRate: completionRate),
      );
    }

    double totalRates = 0;
    double rate;

    for (final routine in weeklyAvgCompletionRate) {
      rate = routine.completionRate as double;
      if (rate != 0) {
        totalRates += rate;
      }
    }

    log("=================================================");
    log("weeklyAvgCompletionRate: $weeklyAvgCompletionRate");
    log("=================================================");

    if (totalRates == 0) {
      return [];
    }

    return weeklyAvgCompletionRate;
  }

  static Future<List<RoutineAverage>> getMonthlyAverageCompletionRate(
      DateTime now) async {
    List<Routine> routines = await getRoutines();
    List<RoutineAverage> monthlyAvgCompletionRate = [];

    DateTime startDay = DateTime.utc(now.year, now.month, 1);
    int numMonths = Time.getMonthDays(now);
    DateTime endDay = startDay.add(Duration(days: numMonths - 1));
    String startDate = DateFormat.yMd().format(startDay);
    String endDate = DateFormat.yMd().format(endDay);

    double numMonthWeeks = numMonths / 7;
    double freqInMonth;
    double completionRate;
    CollectionReference collectionRef;
    QuerySnapshot docs;

    for (Routine routine in routines) {
      collectionRef = routine.docRef!.collection("completedActivities");
      docs = await collectionRef
          .where("date", isGreaterThanOrEqualTo: startDate)
          .where("date", isLessThanOrEqualTo: endDate)
          .get();

      freqInMonth = (numMonthWeeks / (routine.repeatWeeksCount as num)) *
          (routine.repeatDaysCount as num);
      completionRate = (docs.size /
              (routine.numActivities.toDouble() * freqInMonth.toDouble())) *
          100;

      monthlyAvgCompletionRate
          .add(RoutineAverage(routine.name, completionRate));
    }

    return monthlyAvgCompletionRate;
  }

  static Future<int> getStreak() async {
    final DocumentReference docRef = _db.collection("users").doc(_user);
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await docRef.get() as DocumentSnapshot<Map<String, dynamic>>;

    int streak = doc.data()!["streak"];
    return streak;
  }

  static updateStreak() async {
    final DocumentReference docRef = _db.collection("users").doc(_user);
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await docRef.get() as DocumentSnapshot<Map<String, dynamic>>;
    int prevStreak = doc.data()!["streak"];
    int newStreak = prevStreak;
    String lastAct = doc.data()!["lastActDate"];

    DateTime today = DateTime.now();
    DateTime yesterday = Time.subtractDays(today, 1);
    String currDate = DateFormat.yMd().format(today);
    String prevDate = DateFormat.yMd().format(yesterday);

    // NOTE: Should only be valid when there is a change in completed routines section at the current date
    String newAct = currDate;

    if (lastAct != prevDate || lastAct != prevDate) {
      await docRef.update({"streak": newStreak, "lastActDate": newAct});
      return;
    }

    if (lastAct == prevDate) {
      newStreak += 1;
    }

    await docRef.update({"streak": newStreak, "lastActDate": newAct});
  }
}
