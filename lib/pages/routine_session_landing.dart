import 'package:cmsc128_lab/pages/home.dart';
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
  late Widget currentScreen;
  Map<String, dynamic> selectedTasksID = {};

  @override
  void initState() {
    super.initState();
    currentScreen = RoutineSessionList(widget.routineID, _updateSelected);
    getRoutine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()),
                );
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(name)),
      floatingActionButton: Row(children: [
        Spacer(),
        TextButton(
            onPressed: () {
              deleteDialog();
            },
            style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
            child: const Text(
              'Delete Routine',
              style: TextStyle(color: Colors.white),
            )),
        Spacer(),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RoutineSessionOngoing(
                        widget.routineID,
                        routine.numActivities,
                        selectedTasksID)),
              );
            },
            style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
            child: const Text(
              'Start Routine',
              style: TextStyle(color: Colors.white),
            )),
        Spacer()
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: currentScreen,
    );
  }

  void getRoutine() async {
    var snap = await db.getRoutine(widget.routineID).get();
    routine = snap.data() as Routine;
    setState(() {
      name = routine.name;
    });
  }

  void _updateSelected(String category, List taskID) {
    if (selectedTasksID.containsKey(category) && taskID.isEmpty) {
      selectedTasksID.remove(category);
    } else {
      selectedTasksID[category] = taskID;
    }
  }

  void deleteRoutine() async {
    FirestoreUtils.DeleteRoutine(widget.routineID);
  }

  Future deleteDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Delete Routine?'),
            content: Text("This cannot be reversed."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL')),
              TextButton(
                  onPressed: () {
                    deleteRoutine();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar()),
                    );
                  },
                  child: Text('SUBMIT'))
            ],
          ));
}
