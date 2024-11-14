import 'package:cmsc128_lab/widgets/statistics/daily_routine_list.dart';
import 'package:cmsc128_lab/widgets/streaks.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/statistics/daily_routine_chart.dart';

class StatisticsDaily extends StatelessWidget {
  const StatisticsDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Streaks(),
        DailyRoutineChart(),
        DailyRoutineList(),
      ],
    );
  }
}
