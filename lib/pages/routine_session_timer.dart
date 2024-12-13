import 'dart:async';

import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutineSessionTimer extends StatefulWidget {
  int icon;
  String name;
  int duration;
  int index;
  Function changeActivity;

  RoutineSessionTimer(this.name, this.duration, this.icon,this.index,this.changeActivity,{super.key});

  @override
  State<RoutineSessionTimer> createState() {
    return _StateRoutineSessionTimer();
  }
}

class _StateRoutineSessionTimer extends State<RoutineSessionTimer> {
  int icon = 0;
  String name = "";
  int duration = 0;
  int timeFactor = 10;
  double iconScaleFactor = 0.25;
  bool isActive = true;
  int timeAdded = 0;
  Timer? timer;
  late double sizeQuery;

  @override
  void initState() {
    // TODO: implement initState
    name = widget.name;
    duration = widget.duration;
    icon = widget.icon;
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
    sizeQuery = MediaQuery.of(context).size.width;
    timer ??= Timer.periodic(const Duration(seconds: 1), (Timer t) {
      handleTick();
    });

    return  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            textScaler:
                TextScaler.linear(sizeQuery * 0.0065),
          ),
          Icon(IconData(icon, fontFamily: "MaterialIcons"),size: sizeQuery*iconScaleFactor*1.5,color: StyleColor.primary,),
          activityTimer(),
          controlButtons(),
          SizedBox(height: MediaQuery.of(context).size.height*0.115,)
         ],
    );
  }

  void handleTick() {
    if (isActive) {
      setState(() {
        duration--;
        if(duration <= 0){
          isActive = false;
          widget.changeActivity(widget.index+1);
        }

      });
    }
  }

  Widget controlButtons() {
    double size =sizeQuery * iconScaleFactor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: size,
          icon: const Icon(Icons.skip_previous_rounded),
          onPressed: () {
            widget.changeActivity(widget.index-1);
          },
        ),
        IconButton(

          iconSize: size,
          icon: Icon(isActive? Icons.pause_rounded : Icons.play_arrow_rounded),
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
            if(duration <= 0){return;}
            widget.changeActivity(widget.index+1);
          },
        ),
      ],
    );
  }

  Widget activityTimer() {
    double size = sizeQuery*iconScaleFactor*0.5;
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
                timeAdded-=timeFactor;

                duration = duration - timeFactor;
                if(duration < 0){
                  duration = 0;
                }
              });
            },
            icon: const Icon(Icons.remove_rounded)),
        Text(
          textAlign: TextAlign.center,
          strDuration,
          textScaler:
              TextScaler.linear(sizeQuery* 0.009),
          style:GoogleFonts.robotoMono(),
        ),
        IconButton(
            iconSize: size,
            onPressed: () {
              setState(() {
                timeAdded+=timeFactor;
                duration = duration + timeFactor;
              });
            },
            icon: const Icon(Icons.add_rounded))
      ],
    );
  }
}
