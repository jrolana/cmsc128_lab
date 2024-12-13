import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/models/routine.dart';
import 'package:cmsc128_lab/models/activity.dart';
import 'package:cmsc128_lab/models/task_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String ROUTINE_COLLECTION_REF = "routines";

class FirestoreUtils {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  late final CollectionReference _routineRef;
  User? currentUser = FirebaseAuth.instance.currentUser;

  // Get user ID
  // static String uid = FirebaseAuth.instance.currentUser!.uid;
  static String uid = "user1";

  FirestoreUtils() {
    _routineRef = db
        .collection('users')
        .doc(uid)
        .collection(ROUTINE_COLLECTION_REF)
        .withConverter<Routine>(
            fromFirestore: (snapshots, _) =>
                Routine.fromJson(snapshots.data()!),
            toFirestore: (routine, _) => routine.toJson());
  }

  static Future<void> addTask(Map<String, dynamic> task) async {
    try {
      await db.collection('users').doc(uid).collection('tasks').add(task);
      print("Task added successfully!");
    } catch (e) {
      print("Failed to add task: $e");
    }
  }

  static Future<void> deleteTask(String taskId) async {
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
      print("Task deleted successfully!");
    } catch (e) {
      print("Failed to delete task: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getTasks(
      {List<String>? filterCategories}) async {
    try {
      QuerySnapshot querySnapshot =
          await db.collection('users').doc(uid).collection('tasks').get();

      List<Map<String, dynamic>> tasks = querySnapshot.docs
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList();

      if ((filterCategories != null) && (filterCategories.isNotEmpty)) {
        tasks = tasks
            .where((task) => filterCategories.contains(task['category']))
            .toList();
      }

      return tasks;
    } catch (e) {
      print("Failed to fetch tasks: $e");
      return [];
    }
  }

  static Future<void> updateTaskField(
      String taskId, String field, dynamic value) async {
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .update({field: value});
    } catch (e) {
      print('Error updating task field: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getTasksForRoutine(
      String? category) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .where('category', isEqualTo: category)
          .get();

      List<Map<String, dynamic>> tasks = querySnapshot.docs
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList();
          print(tasks);


      tasks = tasks.where((task) => task['isDone'] == false).toList();
      return tasks;
    } catch (e) {
      print("Failed to fetch tasks: $e");
      return [];
    }
  }

  DocumentReference<Object?> getRoutine(routineId) {
    return _routineRef.doc(routineId);
  }

  Future<String> addRoutine(Routine routine, List activities) async {
    String id = 'id';
    String activityCol = 'activities';
    late final CollectionReference activityRef;
    await _routineRef.add(routine).then((DocumentReference doc) {
      id = doc.id;
    });

    activityRef = _routineRef
        .doc(id)
        .collection(activityCol)
        .withConverter<Activity>(
            fromFirestore: (snapshots, _) =>
                Activity.fromJson(snapshots.data()!),
            toFirestore: (activity, _) => activity.toJson());
    for (var member in activities) {
      activityRef.add(member);
    }
    return id;
  }

  CollectionReference<Object?> getActivities(routineID) {
    CollectionReference activityRef = _routineRef
        .doc(routineID)
        .collection('activities')
        .withConverter<Activity>(
            fromFirestore: (snapshots, _) =>
                Activity.fromJson(snapshots.data()!),
            toFirestore: (activity, _) => activity.toJson());
    return activityRef;
  }
}
