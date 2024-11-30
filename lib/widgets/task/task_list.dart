import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskList extends StatefulWidget {
  final List<String> filterCategories;

  const TaskList({super.key, required this.filterCategories});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = true;

  Future<void> fetchTasks({List<String>? filterCategories}) async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> fetchedTasks =
        await FirestoreUtils.getTasks(filterCategories: filterCategories);

    setState(() {
      tasks = fetchedTasks;
      sortTasks();
      isLoading = false;
    });
  }

  @override
  void didUpdateWidget(covariant TaskList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filterCategories != oldWidget.filterCategories) {
      fetchTasks(filterCategories: widget.filterCategories);
    }
  }

  void sortTasks() {
    tasks.sort((a, b) {
      if (a['isDone'] && !b['isDone']) return 1;
      if (!a['isDone'] && b['isDone']) return -1;

      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return dateA.compareTo(dateB);
    });
  }

  @override
  void initState() {
    super.initState();
    // Listen to Firestore changes
    FirebaseFirestore.instance
        .collection('users')
        .doc('8ESa4lmztTB5VUhaJo7r') // Temporary userID
        .collection('tasks')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        tasks = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data(),
          };
        }).toList();

        if (widget.filterCategories.isNotEmpty) {
          tasks = tasks
              .where(
                  (task) => widget.filterCategories.contains(task['category']))
              .toList();
        }
        sortTasks();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tasks.isEmpty) {
      return Expanded(
          child: Center(
              child: Column(
        children: [
          const Icon(IconlyLight.activity),
          const SizedBox(height: 10),
          Text('You have no tasks for this category yet!',
              style: TextStyle(
                  fontFamily: GoogleFonts.lexendDeca().fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: StyleColor.secondary))
        ],
      )));
    }

    return Expanded(
        child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Checkbox(
              value: task['isDone'],
              onChanged: (bool? value) async {
                setState(() {
                  task['isDone'] = value!;
                });

                await FirestoreUtils.updateTaskField(
                    task['id'], 'isDone', value);
              }),
          tileColor: Colors.white,
          title: Text(
            task['name'].toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
                fontFamily: GoogleFonts.lexendDeca().fontFamily,
                decoration: task['isDone'] == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${task['category']}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: GoogleFonts.lexendDeca().fontFamily,
                    color: Colors.black.withOpacity(0.5)),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    IconlyBold.calendar,
                    size: 15,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Text(
                      '${DateFormat('EEEE, MMMM d').format(DateTime.parse(task['date']))}',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: GoogleFonts.lexendDeca().fontFamily,
                          color: Colors.black.withOpacity(0.5)))
                ],
              )
            ],
          ),
          trailing: IconButton(
              icon: const Icon(IconlyBold.delete),
              iconSize: 20,
              onPressed: () async {
                final taskId = task['id'];
                await FirestoreUtils.deleteTask(taskId);
                fetchTasks(filterCategories: widget.filterCategories);
              }),
          isThreeLine: true,
        );
      },
    ));
  }
}