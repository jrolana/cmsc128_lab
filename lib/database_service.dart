import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:intl/intl.dart';

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

  static Stream<List<DayRoutine>> retrieveDayRoutines() async* {
    List<Routine> routines = await retrieveRoutines();
    String now = DateFormat.yMd().format(DateTime.now());
    List<DayRoutine> dayRoutines = [];

    for (Routine routine in routines) {
      CollectionReference collectionRef =
          routine.docRef!.collection("completedActivities");

      QuerySnapshot docs =
          await collectionRef.where("date", isEqualTo: now).get();
      double completionRate =
          (docs.size / (routine.numActivities)!.toDouble()) * 100;

      dayRoutines.add(DayRoutine(
          name: routine.name,
          icon: routine.icon,
          color: routine.color,
          numActivities: routine.numActivities,
          completionRate: completionRate));
    }

    yield dayRoutines;
  }
}
