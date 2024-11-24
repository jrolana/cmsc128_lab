import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/utils/time.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;

class DatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _user = "user1";

  static Future<List<Routine>> retrieveRoutines() async {
    final DocumentReference userRef = _db.collection("users").doc(_user);

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await userRef.collection("routines").get();

    return snapshot.docs
        .map((docSnapshot) => Routine.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  static Stream<List<DayRoutine>> retrieveDayRoutines(DateTime day) async* {
    List<Routine> routines = await retrieveRoutines();
    String now = DateFormat.yMd().format(day);
    List<DayRoutine> dayRoutines = [];

    for (Routine routine in routines) {
      double completionRate = await getDayCompletionRate(routine, now);

      dayRoutines.add(DayRoutine(
          name: routine.name,
          icon: routine.icon,
          color: routine.color,
          numActivities: routine.numActivities,
          completionRate: completionRate));
    }

    yield dayRoutines;
  }

  static Future<double> getDayCompletionRate(
      Routine routine, String now) async {
    CollectionReference collectionRef =
        routine.docRef!.collection("completedActivities");

    QuerySnapshot docs =
        await collectionRef.where("date", isEqualTo: now).get();

    double completionRate =
        (docs.size / (routine.numActivities).toDouble()) * 100;
    return completionRate;
  }

  static Stream<List<WeekRoutine>> retrieveWeekRoutines() async* {
    List<Routine> routines = await retrieveRoutines();
    DateTime now = DateTime.utc(2024, 11, 23);
    List<WeekRoutine> weekRoutines = [];
    List<String> weekdays = ["Sn", "M", "T", "W", "Th", "F", "S"];
    List<int> weekIndices = List.generate(weekdays.length, (index) => index);
    DateTime day = Time.getWeekStart(now);

    for (int i in weekIndices) {
      List<double> rates = [];
      List<Color> colors = [];
      day = Time.addDays(day, i);

      log("$i");
      log(weekdays[i]);
      log(DateFormat.yMd().format(day));

      for (Routine routine in routines) {
        double completionRate =
            await getDayCompletionRate(routine, DateFormat.yMd().format(day));

        rates.add(completionRate);
        colors.add(routine.color);
      }

      weekRoutines.add(WeekRoutine(weekdays[i], rates, colors));
    }

    yield weekRoutines;
  }
}
