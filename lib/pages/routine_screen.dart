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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: const [
                  Text("Completed"),
                  RoutineBlock(),

                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text("Upcoming"),

                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text("Other Routines"),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
