import 'package:flutter/material.dart';
import '../utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/task_data.dart';
import 'package:intl/intl.dart';
import 'package:cmsc128_lab/widgets/searchbox.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SearchBox(),
            Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tasks',
                        style: TextStyle(
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    IconButton(
                        icon: const Icon(Icons.filter_list),
                        iconSize: 25,
                        color: StyleColor.primary,
                        onPressed: () {
                          print("Filter Task"); // Used to test delete button
                        }),
                  ],
                )),
            Expanded(
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  leading: Checkbox(
                      value: task['isDone'],
                      onChanged: (bool? value) {
                        setState(() {
                          task['isDone'] = value!;
                        });
                      }),
                  tileColor: Colors.grey[50],
                  title: Text(
                    task['name'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily),
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
                            Icons.access_time_outlined,
                            size: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          Text(
                              '${DateFormat('EEEE, MMMM d').format(task['date'])}',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black.withOpacity(0.5)))
                        ],
                      )
                    ],
                  ),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 20,
                      onPressed: () {
                        print("Delete Task"); // Used to test delete button
                      }),
                  isThreeLine: true,
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
