import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/routineSession/routine_list.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/widgets/routineSession/routine_timer.dart';

class RoutineSession extends StatefulWidget {
  String routineID;

  RoutineSession(this.routineID, {super.key});

  @override
  State<RoutineSession> createState() => _StateRoutineSession();
}

class _StateRoutineSession extends State<RoutineSession> {
  bool showActivityList = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text('Routine Name Here')),
        floatingActionButton: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
            child: const Text(
              'Start Routine',
              style: TextStyle(color: Colors.white),
            )),
        body: RoutineSessionList(
            's2g1kv6mLOWOijrzRdAj'), //RoutineTimer(Duration(minutes: 10), 'Name of activity',Icons.access_alarms) ,
      ),
    );
  }
}
