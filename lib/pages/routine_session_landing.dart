import 'package:cmsc128_lab/pages/routine_session_ongoing.dart';
import 'package:cmsc128_lab/pages/routine_session_timer.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/routineSession/routine_list.dart';
import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../models/routine.dart';

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
  late Widget currentScreen;

  @override
  void initState() {
    // TODO: implement initState
    currentScreen = RoutineSessionList(widget.routineID);
    getRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(name)),
      floatingActionButton: TextButton(
          onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>RoutineSessionOngoing(widget.routineID)),
            );
          },
          style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
          child: const Text(
            'Start Routine',
            style: TextStyle(color: Colors.white),
          )),
      body:  RoutineSessionList(widget.routineID),
    );
  }

  void getRoutine() async {
    var snap = await db.getRoutine(widget.routineID).get();
    routine = snap.data() as Routine;
    setState(() {
      name = routine.name;
    });
  }

  Widget pages() {
    return StreamBuilder(
        stream: db.getActivities(widget.routineID).snapshots(),
        builder:(context,snapshot){
          List activities = snapshot.data?.docs ?? [];
          return PageView.builder(itemBuilder:(context,index){
            Activity act = activities[index].data();
            return RoutineSessionTimer(act.name, act.duration, act.icon);
          });
        } );
  }

}
