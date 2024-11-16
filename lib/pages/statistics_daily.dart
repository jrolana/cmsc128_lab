import 'package:cmsc128_lab/widgets/statistics/daily_routine_list.dart';
import 'package:cmsc128_lab/widgets/streaks.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/widgets/statistics/daily_completion_rate.dart';

class StatisticsDaily extends StatelessWidget {
  const StatisticsDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const <Widget>[
        Streaks(),
        DailyCompletionRate(),
        DailyRoutineList(),
      ],
    );
  }
}
