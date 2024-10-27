import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/styles.dart';

class StatisticsDay extends StatelessWidget {
  const StatisticsDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadialChart(),
      ],
    );
  }
}

class RadialChart extends StatefulWidget {
  const RadialChart({super.key});

  @override
  State<RadialChart> createState() => _RadialChartState();
}

class _RadialChartState extends State<RadialChart> {
  late List<CompletionRateDay> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SfCircularChart(
        margin: const EdgeInsets.all(15),
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
          RadialBarSeries<CompletionRateDay, String>(
            useSeriesColor: true,
            trackOpacity: 0.1,
            dataSource: _chartData,
            sortingOrder: SortingOrder.ascending,
            sortFieldValueMapper: (CompletionRateDay data, _) =>
                data.routineRate,
            xValueMapper: (CompletionRateDay data, _) => data.routineName,
            yValueMapper: (CompletionRateDay data, _) => data.routineRate,
            pointColorMapper: (CompletionRateDay data, _) => data.color,
            maximumValue: 100,
            radius: '100%',
            cornerStyle: CornerStyle.bothCurve,
          )
        ],
      ),
    ));
  }

  List<CompletionRateDay> getChartData() {
    final List<CompletionRateDay> chartData = [
      CompletionRateDay('Routine 1', 100, StyleColor.secondary),
      CompletionRateDay('Routine 2', 60, StyleColor.accentBlue),
      CompletionRateDay('Routine 3', 70, StyleColor.accentPink),
      CompletionRateDay('Routine 4', 20, StyleColor.secondary),
      CompletionRateDay('Routine 5', 50, StyleColor.accentBlue),
    ];

    return chartData;
  }
}

class CompletionRateDay {
  CompletionRateDay(this.routineName, this.routineRate, this.color);
  final String routineName;
  final int routineRate;
  final Color color;
}
