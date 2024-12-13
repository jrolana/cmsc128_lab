import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../utils/firestore_utils.dart';
import '../utils/styles.dart';

class RoutineSessionTimerTasks extends StatefulWidget {
  String category;
  int duration;
  int index;
  Function changeActivity;
  List tasks;
  RoutineSessionTimerTasks(this.category,this.duration, this.index, this.changeActivity, this.tasks, {super.key});

  @override
  State<RoutineSessionTimerTasks> createState() {
    return _StateRoutineSessionTimerTasks();
  }

}

class _StateRoutineSessionTimerTasks extends State<RoutineSessionTimerTasks> {
  List<Map<String, dynamic>> tasks = [];
  List taskIDs = [];
  bool isLoading = true;
  List<int> selectedTasks = [];
  int icon = 0;
  String name = "";
  int duration = 0;
  int timeFactor = 15;
  double iconScaleFactor = 0.25;
  bool isActive = true;
  int timeAdded = 0;
  Timer? timer;
  late double sizeQuery;



  @override
  void initState() {
    // TODO: implement initState
    duration = widget.duration;
    getTasks();
    print(widget.tasks);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeQuery = MediaQuery
        .of(context)
        .size
        .width;
    timer ??= Timer.periodic(const Duration(seconds: 1), (Timer t) {
      handleTick();
    });

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        taskList(),
        Text(
          "Task Block: ${widget.category}",
          textAlign: TextAlign.center,
          textScaler:
          TextScaler.linear(sizeQuery * 0.0065),
        ),
        activityTimer(),
        controlButtons(),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.115,)
      ],
    );
  }

  void handleTick() {
    if (isActive) {
      setState(() {
        duration--;
        if (duration == 0) {
          widget.changeActivity(widget.index + 1);
        }
      });
    }
  }

  Widget controlButtons() {
    double size = sizeQuery * iconScaleFactor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: size,
          icon: const Icon(Icons.skip_previous_rounded),
          onPressed: () {
            widget.changeActivity(widget.index - 1);
          },
        ),
        IconButton(
          iconSize: size,
          icon: Icon(isActive ? Icons.pause_rounded : Icons.play_arrow_rounded),
          onPressed: () {
            setState(() {
              isActive = !isActive;
            });
          },
        ),
        IconButton(
          iconSize: size,
          icon: const Icon(Icons.skip_next_rounded),
          onPressed: () {
            widget.changeActivity(widget.index + 1);
          },
        ),
      ],
    );
  }

  Widget activityTimer() {
    double size = sizeQuery * iconScaleFactor * 0.5;
    int seconds = duration % 60;
    int minutes = (duration ~/ 60) % 60;
    int hours = duration ~/ (60 * 60) % 24;

    String strSec = seconds.toString().padLeft(2, '0');
    String strMin = minutes.toString().padLeft(2, '0');
    String strHrs = hours.toString().padLeft(2, '0');

    String strDuration = '$strHrs:$strMin:$strSec';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        IconButton(
            iconSize: size,
            onPressed: () {
              setState(() {
                timeAdded -= timeFactor;
                duration = duration - timeFactor;
              });
            },
            icon: const Icon(Icons.remove_rounded)),
        Text(
          textAlign: TextAlign.center,
          strDuration,
          textScaler:
          TextScaler.linear(sizeQuery * 0.009),
          style: GoogleFonts.robotoMono(),
        ),
        IconButton(
            iconSize: size,
            onPressed: () {
              setState(() {
                timeAdded += timeFactor;
                duration = duration + timeFactor;
              });
            },
            icon: const Icon(Icons.add_rounded))
      ],
    );
  }
  Widget tasksChecklist(){
    return ListView.separated(
    shrinkWrap: true,

    itemBuilder: (context,index){

      return ListTile(
        title: Text("Test"),
      );
    },
        separatorBuilder: (context,index){
          return SizedBox(
            height: 10,
          );
        },
        itemCount: tasks.length);
  }
  Widget taskList(){
    return (ListView.separated(
      shrinkWrap: true,
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
          isThreeLine: true,
        );
      },
    ));
  }
  Widget taskCheckbox() {
    return SizedBox(
        height: MediaQuery.of(context).size.height *0.1,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Tasks:",
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: GoogleFonts
                          .lexendDeca()
                          .fontFamily,
                      color: Colors.black),
                ),
                Text(
                  "Your chosen tasks for the routine.",
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: GoogleFonts
                          .lexendDeca()
                          .fontFamily,
                      color: Colors.black.withOpacity(0.5)),
                ),
                const SizedBox(height: 5),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Flexible(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 1),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Row(
                        children: [
                          Checkbox(
                            value: selectedTasks.contains(index),
                            onChanged: (bool? value) {
                              // Add other functions to change data in database here!!!
                              setState(() {
                                if (value == true) {
                                  selectedTasks.add(index);
                                  FirestoreUtils.updateTaskField(task['id'], 'isDone', value);
                                } else {
                                  selectedTasks.remove(index);
                                  FirestoreUtils.updateTaskField(task['id'], 'isDone', value);
                                }
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
                                GoogleFonts
                                    .lexendDeca()
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            )));
  }

  void getTasks() async{
    List taskIDList = widget.tasks;

    for (String x in taskIDList){
        var task = FirestoreUtils.getTask(x);
        print(task);
        task.then((snap){
          if(snap != null){
            print(snap);
            tasks.add(snap);
          }
        });
      isLoading = false;
    }
  }
}