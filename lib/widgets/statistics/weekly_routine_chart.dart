import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';
import 'package:cmsc128_lab/utils/styles.dart';

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

    final List<int> indices =
        List.generate(routineNames.length, (index) => index);

    return Center(
        child: Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SfCartesianChart(
        margin: const EdgeInsets.all(30),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          textStyle: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.lexendDeca().fontFamily,
          ),
        ),
        primaryYAxis: NumericAxis(
          maximum: 100,
          labelStyle: TextStyle(
            color: Colors.black54,
            fontFamily: GoogleFonts.lexendDeca().fontFamily,
          ),
        ),
        series: indices.map((i) {
          return StackedColumnSeries<WeekRoutine, String>(
            name: routineNames[i],
            dataSource: chartData,
            xValueMapper: (WeekRoutine data, _) => data.day,
            yValueMapper: (WeekRoutine data, _) =>
                data.weeklyCompletionRates[i],
            pointColorMapper: (WeekRoutine data, _) => data.colors[i],
            width: 0.2,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          );
        }).toList(),
      ),
    ));
  }
}
