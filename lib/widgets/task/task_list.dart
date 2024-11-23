import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/data/task_data.dart';
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  final List<String> filterCategories;

  const TaskList({super.key, required this.filterCategories});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final filteredTasks = widget.filterCategories.isEmpty
        ? tasks
        : tasks.where((task) {
            return widget.filterCategories.contains(task['category']);
          }).toList();

    if (filteredTasks.isEmpty) {
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
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Checkbox(
              value: task['isDone'],
              onChanged: (bool? value) {
                setState(() {
                  task['isDone'] = value!;
                });
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
                    ? TextDecoration.lineThrough // Apply strikethrough
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
                  Text('${DateFormat('EEEE, MMMM d').format(task['date'])}',
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
              onPressed: () {
                print("Delete Task"); // Used to test delete button
              }),
          isThreeLine: true,
        );
      },
    ));
  }
}
