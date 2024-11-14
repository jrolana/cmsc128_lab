import 'package:cmsc128_lab/widgets/statistics/weekly_routine_list.dart';
import 'package:cmsc128_lab/widgets/switch_date.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/widgets/statistics/weekly_routine_chart.dart';

class StatisticsWeekly extends StatelessWidget {
  const StatisticsWeekly({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        SwitchDate(),
        WeeklyRoutineChart(),
        TopWeeklyRoutineList(),
        BottomWeeklyRoutineList(),
      ],
    );
  }
}
