import 'package:cmsc128_lab/pages/routine_session_timer.dart';
import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../models/routine.dart';
import '../utils/firestore_utils.dart';


class RoutineSessionOngoing extends StatefulWidget {
  final String routineID;

  const RoutineSessionOngoing(this.routineID, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateRoutineSessionOngoing();
  }
}

class _StateRoutineSessionOngoing extends State<RoutineSessionOngoing> {
  FirestoreUtils db = FirestoreUtils();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
          ),
          title: const Text('Routine Session'),
        ),
        body: pages(),
    );
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