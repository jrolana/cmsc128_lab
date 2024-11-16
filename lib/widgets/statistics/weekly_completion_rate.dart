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
  late List<WeekRoutine> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  List<WeekRoutine> getChartData() {
    return weeklyData;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> routineNames = routineData.map((routine) {
      return routine.name;
    }).toList();

    final List<int> indices =
        List.generate(routineNames.length, (index) => index);

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Routine Completion Rate",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 400,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SfCartesianChart(
              margin: const EdgeInsets.all(30),
              title: ChartTitle(
                  text:
                      "Progress builds one day at a time – keep stacking those wins!",
                  textStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: GoogleFonts.lexendDeca().fontFamily)),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle:
                    TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
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
                  dataSource: _chartData,
                  xValueMapper: (WeekRoutine data, _) => data.day,
                  yValueMapper: (WeekRoutine data, _) =>
                      data.weeklyCompletionRates[i],
                  pointColorMapper: (WeekRoutine data, _) => data.colors[i],
                  width: 0.2,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
