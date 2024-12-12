import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/firestore_utils.dart';
import '../utils/styles.dart';

class RoutineSessionTimerTasks extends StatefulWidget {
  int duration;
  int index;
  Function changeActivity;
  Function sendTaskID;

  RoutineSessionTimerTasks(this.duration, this.index, this.changeActivity,
      this.sendTaskID);

  @override
  State<RoutineSessionTimerTasks> createState() {
    return _StateRoutineSessionTimerTasks();
  }

}

class _StateRoutineSessionTimerTasks extends State<RoutineSessionTimerTasks> {
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = true;
  List<int> selectedTasks = [];
  int icon = 0;
  String name = "";
  int duration = 0;
  int timeFactor = 10;
  double iconScaleFactor = 0.25;
  bool isActive = true;
  int timeAdded = 0;
  Timer? timer;
  late double sizeQuery;
  Future<void> fetchTasks({String? category}) async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> fetchedTasks =
    await FirestoreUtils.getTasksForRoutine(category);

    setState(() {
      tasks = fetchedTasks;
      isLoading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    duration = widget.duration;
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
        Text(
          name,
          textAlign: TextAlign.center,
          textScaler:
          TextScaler.linear(sizeQuery * 0.0065),
        ),
        Icon(IconData(icon, fontFamily: "MaterialIcons"),
          size: sizeQuery * iconScaleFactor * 1.5, color: StyleColor.primary,),
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

  Widget taskCheckbox() {
    return SizedBox(
        height: 300,
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
                    const SizedBox(height: 5),
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
                                } else {
                                  selectedTasks.remove(index);
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
}