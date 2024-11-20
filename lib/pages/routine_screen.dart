import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_home_routine_block.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => RoutineScreenState();
}

class RoutineScreenState extends State<RoutineScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Column(

              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Completed Today",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30,)),
                  ),
                RoutineBlock(),

              ],
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Upcoming Today",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30,)),
                    ),
                  RoutineBlock(),
                  RoutineBlock(),

                ],
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Other Routines",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30,)),
                  ),
                RoutineBlock(),
                RoutineBlock(),
                RoutineBlock(),
                RoutineBlock(),

              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
