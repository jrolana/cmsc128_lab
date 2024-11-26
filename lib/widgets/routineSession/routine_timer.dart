import 'dart:async';

import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';

class RoutineTimer extends StatefulWidget{
  Duration dur;
  String actName;
  IconData actIcon;
  RoutineTimer(this.dur,this.actName,this.actIcon,{super.key});


  @override
  State<RoutineTimer> createState() => _RoutineTimerState(dur,actName,actIcon);
}

class _RoutineTimerState extends State<RoutineTimer> {
  Duration dur;
  String actName;
  IconData actIcon;
  Timer? timer;
  int totalTime;
  bool isActive = false;
  bool overtime = false;

  _RoutineTimerState(this.dur, this.actName, this.actIcon)
      :totalTime = dur.inSeconds.toInt();


  void handleTick() {
    if (isActive) {
      setState(() {
        totalTime --;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    timer ??= Timer.periodic(const Duration(seconds: 1), (Timer t) {
      handleTick();
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        timerSection(),
        Icon(color: StyleColor.primary,size:100,actIcon),
        SizedBox(height: 20),
        Text(actName,textScaler: const TextScaler.linear(1.5),),
        controlButtons()
      ],
    );
  }

  Widget controlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            iconSize: 100,
            onPressed: () {}, icon: const Icon(Icons.skip_previous_rounded)),
        IconButton(
            iconSize: 100,
            onPressed: () {
              setState(() {
                isActive = !isActive;
            });
        },
            icon: Icon(
                isActive ? Icons.pause_rounded : Icons.play_arrow_rounded)),
        IconButton(iconSize: 100,onPressed: () {}, icon: const Icon(Icons.skip_next_rounded))
      ],
    );
  }

  Widget timerSection() {
    int seconds = totalTime % 60;
    int hours = totalTime ~/ (60 * 60) % 24;
    int minutes = (totalTime ~/ 60) % 60;
    String sec = seconds.toString().padLeft(2,'0');
    String hr = hours.toString().padLeft(2,'0');
    String mins = minutes.toString().padLeft(2,'0');
    String durString ='$hr:$mins:$sec';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(color:StyleColor.primary,iconSize: 100,onPressed: () {setState(() {
          totalTime = totalTime-30;
        });}, icon: const Icon(Icons.remove_rounded)),
        Text(textScaler: const TextScaler.linear(3),durString),
        IconButton(color: StyleColor.primary,iconSize:100,onPressed: () {
          setState(() {
            totalTime = totalTime+30;
          });
        }, icon: const Icon(Icons.add_rounded))
      ],
    );
  }
}