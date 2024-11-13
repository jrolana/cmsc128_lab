import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';

class WeeklyRoutineChart extends StatefulWidget {
  const WeeklyRoutineChart({super.key});

  @override
  State<WeeklyRoutineChart> createState() => _WeeklyRoutineChartState();
}

class _WeeklyRoutineChartState extends State<WeeklyRoutineChart> {
  @override
  Widget build(BuildContext context) {
    final List<WeekRoutine> chartData = weeklyData;
    final List<String> routineNames = routineData.map((routine) {
      return routine.name;
    }).toList();

    return Center(
        child: Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SfCartesianChart(
        margin: const EdgeInsets.all(30),
        title: ChartTitle(
            text: 'See your progress for this week.',
            textStyle: TextStyle(
                fontSize: 12, fontFamily: GoogleFonts.lexendDeca().fontFamily)),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          textStyle: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
        ),
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries>[
          StackedColumnSeries<WeekRoutine, String>(
            name: routineNames[0],
            dataSource: chartData,
            xValueMapper: (WeekRoutine data, _) => data.day,
            yValueMapper: (WeekRoutine data, _) =>
                data.weeklyCompletionRates[0],
            pointColorMapper: (WeekRoutine data, _) => data.colors[0],
          ),
          StackedColumnSeries<WeekRoutine, String>(
            name: routineNames[1],
            dataSource: chartData,
            xValueMapper: (WeekRoutine data, _) => data.day,
            yValueMapper: (WeekRoutine data, _) =>
                data.weeklyCompletionRates[1],
            pointColorMapper: (WeekRoutine data, _) => data.colors[1],
          ),
          StackedColumnSeries<WeekRoutine, String>(
            name: routineNames[2],
            dataSource: chartData,
            xValueMapper: (WeekRoutine data, _) => data.day,
            yValueMapper: (WeekRoutine data, _) =>
                data.weeklyCompletionRates[2],
            pointColorMapper: (WeekRoutine data, _) => data.colors[2],
          ),
          StackedColumnSeries<WeekRoutine, String>(
            name: routineNames[3],
            dataSource: chartData,
            xValueMapper: (WeekRoutine data, _) => data.day,
            yValueMapper: (WeekRoutine data, _) =>
                data.weeklyCompletionRates[3],
            pointColorMapper: (WeekRoutine data, _) => data.colors[3],
          ),
          StackedColumnSeries<WeekRoutine, String>(
            name: routineNames[4],
            dataSource: chartData,
            xValueMapper: (WeekRoutine data, _) => data.day,
            yValueMapper: (WeekRoutine data, _) =>
                data.weeklyCompletionRates[4],
            pointColorMapper: (WeekRoutine data, _) => data.colors[4],
          ),
        ],
      ),
    ));
  }
}
