import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/statistics/weekly_routine_list.dart';
import 'package:cmsc128_lab/widgets/switch_date.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/widgets/statistics/weekly_completion_rate.dart';

class StatisticsWeekly extends StatelessWidget {
  const StatisticsWeekly({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        const SwitchDate(),
        const WeeklyRoutineChart(),
        const WeeklyRoutineList(
          isTop: true,
          title: "Top Routines",
          iconColor: StyleColor.gold,
          iconBgColor: Color.fromARGB(255, 255, 247, 198),
        ),
        WeeklyRoutineList(
          isTop: false,
          title: "Routines to Focus On",
          iconColor: Colors.red,
          iconBgColor: Colors.red[50]!,
        ),
      ],
    );
  }
}
