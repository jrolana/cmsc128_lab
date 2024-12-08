import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_task_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/task_selection_block.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/models/routine.dart';
import 'package:cmsc128_lab/models/activity.dart';

class RoutineCreation extends StatefulWidget {
  const RoutineCreation({super.key});

  @override
  State<RoutineCreation> createState() {
    return _RoutineCreationDefaultState();
  }
}

class _RoutineCreationDefaultState extends State<RoutineCreation>
    with TickerProviderStateMixin {
  int actCount = 1;
  List activityBlocks = [ActivityBlock()];
  IconData icon = Icons.add;
  String routineName = "Routine Name";
  FirestoreUtils dbService = FirestoreUtils();

  Widget titleText() {
    return TextButton(
        onPressed: () {
          openDialog();
        },
        child: Container(
            alignment: FractionalOffset.center,
            decoration: myBoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              children: [
                Text(
                  routineName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "Routine Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w100, color: Colors.white),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: () {
                addActivity();
              },
              style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
              icon: Icon(
                Icons.playlist_add_rounded,
                color: Colors.white,
              )),
          ElevatedButton(
              onPressed: () {
                addTaskBlock();
              },
              child: Text('Add Task Block')),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: StyleColor.primary),
              onPressed: () {
                createRoutineDialog();
              },
              child: Text(
                "Create Routine",
                style: TextStyle(color: Colors.white),
              )),
        ]),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Home',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Create a Routine'),
        ),
        body: Column(
          children: [
            titleText(),
            SizedBox(height: 20),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: activityBlocks[index],
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                activityBlocks.removeAt(index);
                                actCount -= 1;
                              });
                            },
                            icon: Icon(Icons.delete)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: actCount))
          ],
        ),
      ),
    );
  }

  void addActivity() {
    setState(() {
      activityBlocks.add(ActivityBlock());
      actCount += 1;
    });
  }

  void addTaskBlock() {
    setState(() {
      // activityBlocks.add(TaskSelectBlock(category: "School")); // For Selection of Task Sample
      activityBlocks.add(TaskBlock());
      actCount += 1;
    });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: StyleColor.tertiary),
      color: StyleColor.primary,
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  TextEditingController inputController = TextEditingController();

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Enter Routine Name'),
          content: TextField(
            controller: inputController,
            autofocus: true,
            decoration: InputDecoration(hintText: "Enter routine name"),
          ),
          actions: [
            TextButton(
              child: Text('SUBMIT'),
              onPressed: () {
                setState(() {
                  routineName = inputController.text;
                  Navigator.of(context).pop();
                });
              },
            )
          ],
        ),
      );

  Future createRoutineDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Create the Routine'),
            content: Row(
              children: [

              ],
            ),
            actions: [
              TextButton(onPressed: (){
                //createRoutineDB();
              }, child: Text('SUBMIT'))
            ],
          )
  );

  void createRoutineDB() {
    Routine routine = Routine(
        color: 128390830,
        icon: icon.toString(),
        name: routineName,
        numActivities: actCount,
        repeatDaysCount: 1,
        repeatWeeksCount: 1,
        daysOfWeek: [1,2,3]);
    List<Activity> activities = [];
    for (var member in activityBlocks) {
      activities.add(Activity(
          name: member.getName(),
          icon: member.getIcon(),
          duration: member.getDuration()));
    }

    dbService.addRoutine(routine, activities);
  }
}
