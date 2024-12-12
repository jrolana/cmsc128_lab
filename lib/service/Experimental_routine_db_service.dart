import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/models/routine.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

//FOR HOME ROUTINE

class DBroutineService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _collection_ref;

  User? currentUser = FirebaseAuth.instance.currentUser;

  // Get user ID
  static String routineid = FirebaseAuth.instance.currentUser!.uid;

  final DateTime now = DateTime.now().toLocal();

  DBroutineService() {
    _collection_ref = _firestore
        .collection('users')
        .doc(routineid)
        .collection('routines')
        .withConverter<Routine>(
            fromFirestore: (snapshots, _) => Routine.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (routine, _) => routine.toJson());
  }

  Stream<QuerySnapshot> getRoutine() {
    return _collection_ref.snapshots();
  }

  Stream<QuerySnapshot> getUpcoming() {
    late final _upcoming = FirebaseFirestore.instance
        .collection('users')
        .doc(routineid)
        .collection('routines')
        .withConverter<Routine>(
            fromFirestore: (snapshots, _) => Routine.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (routine, _) => routine.toJson())
        .where('daysOfWeek',
            arrayContains: DateFormat('EEEE').format(now).toLowerCase());
    return _upcoming.snapshots();
  }

  Stream<QuerySnapshot> getOthers() {
    late final _others = FirebaseFirestore.instance
        .collection('users')
        .doc(routineid)
        .collection('routines')
        .withConverter<Routine>(
            fromFirestore: (snapshots, _) => Routine.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (routine, _) => routine.toJson())
        .where('daysOfWeek',
            whereNotIn: [DateFormat('EEEE').format(now).toLowerCase()]);
    return _others.snapshots();
  }

  Stream<QuerySnapshot> getCompleted() {
    late final _completed = FirebaseFirestore.instance
        .collection('users')
        .doc(routineid)
        .collection('routines')
        .withConverter<Routine>(
            fromFirestore: (snapshots, _) => Routine.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (routine, _) => routine.toJson())
        .where('numActivities', isEqualTo: 0);
    return _completed.snapshots();
  }
}
