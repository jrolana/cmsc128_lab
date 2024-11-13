import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';

class DailyRoutineChart extends StatefulWidget {
  const DailyRoutineChart({super.key});

  @override
  State<DailyRoutineChart> createState() => _DailyRoutineChartState();
}

class _DailyRoutineChartState extends State<DailyRoutineChart> {
  late List<DayRoutine> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SfCircularChart(
        margin: const EdgeInsets.all(20),
        title: ChartTitle(
            text: 'Your today\'s routines are almost done—keep it up!',
            textStyle: TextStyle(
                fontSize: 12, fontFamily: GoogleFonts.lexendDeca().fontFamily)),
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.right,
          textStyle: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
        ),
        series: <CircularSeries>[
          RadialBarSeries<DayRoutine, String>(
            useSeriesColor: true,
            trackOpacity: 0.1,
            dataSource: _chartData,
            sortingOrder: SortingOrder.ascending,
            sortFieldValueMapper: (DayRoutine data, _) =>
                data.dailyCompletionRate,
            xValueMapper: (DayRoutine data, _) => data.name,
            yValueMapper: (DayRoutine data, _) => data.dailyCompletionRate,
            pointColorMapper: (DayRoutine data, _) => data.color,
            maximumValue: 100,
            radius: '100%',
            cornerStyle: CornerStyle.bothCurve,
          )
        ],
      ),
    ));
  }

  List<DayRoutine> getChartData() {
    final List<DayRoutine> chartData = dailyData;

    return chartData;
  }
}
