import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/components/statistics/daily_routine_chart.dart';
import 'package:iconly/iconly.dart';

class DailyRoutineList extends StatefulWidget {
  const DailyRoutineList({super.key});

  @override
  State<DailyRoutineList> createState() => _DailyRoutineListState();
}

class _DailyRoutineListState extends State<DailyRoutineList> {
  late List<DayRoutine> listData;

  @override
  void initState() {
    listData = [
      DayRoutine('Routine 1', 10, StyleColor.secondary, true),
      DayRoutine('Routine 2', 3, StyleColor.accentBlue, true),
      DayRoutine('Routine 3', 7, StyleColor.accentPink, true),
      DayRoutine('Routine 4', 2, StyleColor.secondary, false),
      DayRoutine('Routine 5', 5, StyleColor.accentBlue, false),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: listData.map((entry) {
            // TASK: Only create widgets only those that are not yet started
            return RoutineCard(
              name: entry.name,
              numActivities: entry.numActivities,
              color: entry.color,
            );
          }).toList(),
        ));
  }
}

class DayRoutine {
  DayRoutine(this.name, this.numActivities, this.color, this.isComplete);
  final String name;
  final int numActivities;
  final Color color;
  final bool isComplete;
}

class RoutineCard extends StatelessWidget {
  const RoutineCard({
    super.key,
    required this.name,
    required this.numActivities,
    required this.color,
  });

  final String name;
  final int numActivities;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(IconlyBold.bag_2),
        iconColor: color,
        title: Text(name),
        subtitle: Text("$numActivities activities"),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.lexendDeca().fontFamily),
        subtitleTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontFamily: GoogleFonts.lexendDeca().fontFamily),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
