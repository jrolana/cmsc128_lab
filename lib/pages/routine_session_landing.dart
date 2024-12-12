import 'package:cmsc128_lab/pages/routine_session_ongoing.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/routineSession/routine_list.dart';
import 'package:flutter/material.dart';

import '../models/routine.dart';
import 'navbar.dart';

class RoutineSessionLanding extends StatefulWidget {
  final String routineID;

  const RoutineSessionLanding(this.routineID, {super.key});

  @override
  State<RoutineSessionLanding> createState() => _StateRoutineSessionLanding();
}

class _StateRoutineSessionLanding extends State<RoutineSessionLanding> {
  FirestoreUtils db = FirestoreUtils();
  String name = "";
  late Routine routine;
  late Widget routineList;
  Map<String,List> tasks = {};

  @override
  void initState() {
    // TODO: implement initState
    routineList =  RoutineSessionList(widget.routineID,_getTasks);
    getRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>BottomNavBar()),
                );
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(name)),
      floatingActionButton: TextButton(
          onPressed: (){

            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>RoutineSessionOngoing(widget.routineID,routine.numActivities,tasks)),
            );
          },
          style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
          child: const Text(
            'Start Routine',
            style: TextStyle(color: Colors.white),
          )),
      body: routineList,
    );
  }

  void getRoutine() async {
    var snap = await db.getRoutine(widget.routineID).get();
    routine = snap.data() as Routine;
    setState(() {
      name = routine.name;
    });
  }
  void _getTasks(List taskIDs,String category){
    if(taskIDs != []){
      tasks[category] = taskIDs;
    }
  }


}
