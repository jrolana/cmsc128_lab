import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtils {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  // Get user ID
  static String uid = '8ESa4lmztTB5VUhaJo7r';

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
}
