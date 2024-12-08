import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';

class TaskSelectBlock extends StatefulWidget {
  final String category;

  const TaskSelectBlock({super.key, required this.category});

  @override
  State<TaskSelectBlock> createState() => _TaskSelectBlockState();
}

class _TaskSelectBlockState extends State<TaskSelectBlock> {
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = true;
  int? selectedTask;

  Future<void> fetchTasks({String? category}) async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> fetchedTasks =
        await FirestoreUtils.getTasksForRoutine(category);

    setState(() {
      tasks = fetchedTasks;
      sortTasks();
      isLoading = false;
    });
  }

  void sortTasks() {
    tasks.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return dateA.compareTo(dateB);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTasks(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
          height: 300,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "${widget.category} Task:",
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                        color: Colors.black),
                  ),
                  Text(
                    "Choose a task to add to your routine",
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 5),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Flexible(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return Row(
                                children: [
                                  Checkbox(
                                    value: selectedTask == index,
                                    onChanged: (bool? value) {
                                      // Add other functions to change data in database here!!!
                                      setState(() {
                                        selectedTask =
                                            value == true ? index : null;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      task['name'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily:
                                            GoogleFonts.lexendDeca().fontFamily,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ],
              ))),
    );
  }
}
