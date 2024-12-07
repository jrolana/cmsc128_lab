import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_title.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                print('Add Task Block');
              },
              child: Text('Add Task Block')),
          ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: StyleColor.primary),
              onPressed: () {
                Routine routine = Routine(
                    color: 128390830,
                    icon: icon.toString(),
                    name: routineName,
                    numActivities: actCount,
                    repeatDaysCount: 1,
                    repeatWeeksCount: 1);
                List<Activity> activities = [];
                for (var member in activityBlocks) {
                  activities.add(
                        Activity(name: member.getName(), icon: member.getIcon(), duration: member.getDuration()));
                }

               dbService.addRoutine(routine, activities);
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
            RCreationActivityName(routineName),
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

  Widget makeList() {
    return ListView(
      children: [ActivityBlock()],
    );
  }

  void addActivity() {
    setState(() {
      activityBlocks.add(ActivityBlock());
      actCount += 1;
    });
  }

// TODO figure out reorderable list view if possible
// Widget makeList() {
//   return ReorderableListView(
//     proxyDecorator: (child,index,animation) =>
//         Material(
//             borderRadius: BorderRadius.circular(100),
//             child:child
//         ),
//     shrinkWrap: true,
//     children: [
//       for (int index = 0; index < actCount; index += 1)
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 2.0),
//           key: Key('$index'),
//           child:ActivityBlock(),
//         )
//     ],
//     onReorder: (int oldIndex, int newIndex) {
//       setState(() {
//         if (oldIndex < newIndex) {
//           newIndex -= 1;
//         }
//         final int item = _items.removeAt(oldIndex);
//         _items.insert(newIndex, item);
//       });
//     },
//   );
// }
}
