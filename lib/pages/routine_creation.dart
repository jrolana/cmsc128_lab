import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_title.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';

class RoutineCreation extends StatefulWidget {
  const RoutineCreation({super.key});

  @override
  State<RoutineCreation> createState() {
    return _RoutineCreationDefaultState();
  }
}

class _RoutineCreationDefaultState extends State<RoutineCreation> with TickerProviderStateMixin {
  int actCount  = 1;
  //List<int> _items = List<int>.generate(1, (int index) => index);
  List<ActivityBlock> activityBlocks = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
            onPressed: () {},
            child: Container(
                padding: EdgeInsets.all(8),
                color: StyleColor.primary,
                child: Text("Create Routine",
                    style: TextStyle(color: Colors.white))),
          ),
          Container(
              padding: EdgeInsets.all(9),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      activityBlocks.add(ActivityBlock());
                      print(activityBlocks);
                    });

                  },
                  style:
                      TextButton.styleFrom(backgroundColor: StyleColor.primary),
                  child: Icon(
                    Icons.playlist_add_rounded,
                    color: Colors.white,
                  ))),
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
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RCreationActivityName(),
                SizedBox(height: 20),
                ListView.builder(itemBuilder:(context,index){
                  return
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeList(){
    return ListView(
      children: [
        ActivityBlock()
      ],
    );
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
