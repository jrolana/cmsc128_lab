import 'package:cmsc128_lab/pages/navbar.dart';
import 'package:cmsc128_lab/service/database_service.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/routine.dart';

class RoutineSessionComplete extends StatefulWidget {
  final String routineID;

  const RoutineSessionComplete(this.routineID, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _StateRoutineSessionComplete();
  }
}

class _StateRoutineSessionComplete extends State<RoutineSessionComplete> {
  FirestoreUtils db = FirestoreUtils();
  DatabaseService statsDB = DatabaseService();
  String name = "";
  late Routine routine;
  late Widget currentScreen;

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoutine();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [completionStatistics()],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            DatabaseService.updateStreak();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
          },
          child: Row(
            children: [
              Icon(Icons.check_circle_outline_rounded),
              Text('Finish Routine')
            ],
          ),
      ),
    );
  }

  Widget completionStatistics() {
    return Column(
      children: [
        Text("Well done! You completed $name"),
      ],
    );
  }

  Widget confirmTaskComplete() {
    // TODO for completion of tasks
    throw UnimplementedError();
  }

  void getRoutine() async {
    var snap = await db.getRoutine(widget.routineID).get();
    routine = snap.data() as Routine;
    setState(() {
      name = routine.name;
    });
  }
}
