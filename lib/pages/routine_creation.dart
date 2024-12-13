import 'package:cmsc128_lab/models/task_block.dart';
import 'package:cmsc128_lab/pages/navbar.dart';
import 'package:cmsc128_lab/pages/routine_session_landing.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_task_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/task_selection_block.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:day_picker/day_picker.dart';
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
  String routineName = "Click to set routine name";
  List repeatDays = [];
  FirestoreUtils dbService = FirestoreUtils();
  String selectedCategory = '';
  List<String> selectedCategories = [];
  List<String?> remainingCategories = [
    "Personal",
    "School",
    "Work",
    "Home",
    "Health",
    "Social",
    "Financial"
  ];

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
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 20),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          addActivity();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: StyleColor.primary),
                        icon: Icon(
                          Icons.playlist_add_rounded,
                          color: Colors.white,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          addTaskBlock();
                        },
                        child: Text('Add Task Block')),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: StyleColor.primary),
                    onPressed: () {
                      if( routineName == "Click to set routine name"){
                        setNameDialog();
                      }else{
                      createRoutineDialog();}
                    },
                    child: Text(
                      "Create Routine",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ]),
        ),
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
                      var block = activityBlocks[index];
                      return ListTile(
                        title: block,
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                if (block is TaskBlock) {
                                  String? category =
                                      block.getSelectedCategory();

                                  remainingCategories.add(category);
                                  selectedCategories.remove(category);
                                  activityBlocks.removeAt(index);
                                  actCount -= 1;
                                } else {
                                  activityBlocks.removeAt(index);
                                  actCount -= 1;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              size: width * 0.06,
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: height * 0.0001,
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
    if (remainingCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All categories are already added.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a category for this task block:'),
          content: SingleChildScrollView(
            child: Column(
              children: remainingCategories.map((category) {
                return ListTile(
                  title: Text(category!),
                  onTap: () {
                    selectedCategory = category;
                    Navigator.pop(context, category);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    ).then((selectedCategory) {
      if (selectedCategory != null) {
        setState(() {
          activityBlocks.add(TaskBlock(selectedCategory: selectedCategory));
          remainingCategories.remove(selectedCategory);
          selectedCategories.add(selectedCategory);
          print('Remaining categories before dialog: $remainingCategories');
          actCount += 1;
        });
      }
    });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: StyleColor.tertiary),
      color: StyleColor.primary,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Shadow color
          spreadRadius: 2, // How much the shadow spreads
          blurRadius: 5, // How blurry the shadow is
          offset: Offset(0, 4), // The shadow's position (x, y)
        ),
      ],
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
                if (inputController.text.isEmpty){
                  inputController.text = "Click to set routine name";
                }
                setState(() {
                  Navigator.pop(context);
                  routineName = inputController.text;
                });
              },
            )
          ],
        ),
      );
  Future setNameDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Enter Routine Name First'),
      content: TextField(
        controller: inputController,
        autofocus: true,
        decoration: InputDecoration(hintText: "Enter routine name"),
      ),
      actions: [
        TextButton(
          child: Text('SUBMIT'),
          onPressed: () {
            if (inputController.text.isEmpty){
              inputController.text = "Click to set routine name";
            }
            setState(() {
              Navigator.pop(context);
              routineName = inputController.text;
            });
          },
        )
      ],
    ),
  );
  final List<DayInWeek> _days = [
    DayInWeek("Mo", dayKey: "monday"),
    DayInWeek("Tu", dayKey: "tuesday"),
    DayInWeek("We", dayKey: "wednesday"),
    DayInWeek("Th", dayKey: "thursday"),
    DayInWeek("Fr", dayKey: "friday"),
    DayInWeek("Sa", dayKey: "saturday"),
    DayInWeek("Su", dayKey: "sunday"),
  ];

  Future createRoutineDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Finalize Routine'),
            content: Column(
              children: [
                Text(
                  routineName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                SizedBox(height: 10),
                SelectWeekDays(
                  onSelect: (values) {
                    repeatDays = values;
                  },
                  days: _days,
                  width: MediaQuery.of(context).size.width,
                  boxDecoration: BoxDecoration(
                    color: StyleColor.primary,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL')),
              TextButton(
                  onPressed: () {
                    createRoutineDB();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar()),
                    );
                  },
                  child: Text('SUBMIT'))
            ],
          ));

  void createRoutineDB() {
    Routine routine = Routine(
        color: 128390830,
        name: routineName,
        numActivities: actCount,
        repeatDaysCount: repeatDays.isEmpty? 1:repeatDays.length.toDouble(),
        repeatWeeksCount: 1,
        daysOfWeek: repeatDays);
    List activities = [];

    for (var member in activityBlocks) {
      if (member.type == 'activity') {
        activities.add(
          Activity(
              order: activityBlocks.indexOf(member),
              name: member.getName(),
              icon: member.getIcon(),
              duration: member.getDuration(),
              type: 'activity',
              category: "none"),
        );
      } else {
        activities.add(Activity(
            order: activityBlocks.indexOf(member),
            name: "none",
            icon: 0,
            duration: member.getDuration(),
            type: 'taskblock',
            category: member.selectedCategory));
      }
    }
    dbService.addRoutine(routine, activities).then((result) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RoutineSessionLanding(result)));
    });
  }



}
