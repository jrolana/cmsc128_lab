import 'package:flutter/material.dart';
import 'package:cmsc128_lab/widgets/statistics/monthly_completion_rate.dart';

class StatisticsMonthly extends StatelessWidget {
  const StatisticsMonthly({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const <Widget>[
        MonthlyCompletionRate(),
      ],
    );
  }
}
