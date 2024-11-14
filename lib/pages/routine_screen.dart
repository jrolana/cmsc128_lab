import 'package:cmsc128_lab/routineWidgets/rScreenRoutineBlock.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/data/task_data.dart';
import 'package:intl/intl.dart';
import 'package:cmsc128_lab/widgets/searchbox.dart';

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
            Container(
              child: Column(
                
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Completed Today",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30,)),
                    ),
                  RoutineBlock(),

                ],
              ),
            ),
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
            Container(
              child: Column(
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
            ),
          ],
        ),
      ),
      ),
    );
  }
}
