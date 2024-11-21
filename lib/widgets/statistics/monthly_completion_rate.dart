import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';

class MonthlyCompletionRate extends StatefulWidget {
  const MonthlyCompletionRate({super.key});

  @override
  State<MonthlyCompletionRate> createState() => _MonthlyCompletionRateState();
}

class _MonthlyCompletionRateState extends State<MonthlyCompletionRate> {
  late List<MonthRoutine> _thirdMonthData;
  late List<MonthRoutine> _prevMonthData;
  late List<MonthRoutine> _currMonthData;

  @override
  void initState() {
    _thirdMonthData = getThirdMonthData();
    _prevMonthData = getPrevMonthData();
    _currMonthData = getCurrMonthData();

    super.initState();
  }

  List<MonthRoutine> getThirdMonthData() {
    return thirdMonthData;
  }

  List<MonthRoutine> getPrevMonthData() {
    return prevMonthData;
  }

  List<MonthRoutine> getCurrMonthData() {
    return currMonthData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Routine Average Completion Rate",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SfCartesianChart(
              margin: const EdgeInsets.all(30),
              title: ChartTitle(
                  text:
                      "Incredible progress already—stay focused, and the sky’s the limit!",
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
                labelPlacement: LabelPlacement.onTicks,
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.lexendDeca().fontFamily,
                ),
              ),
              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                  fontFamily: GoogleFonts.lexendDeca().fontFamily,
                ),
              ),
              series: <CartesianSeries>[
                StackedLineSeries<MonthRoutine, String>(
                    name: months[0],
                    dataSource: _thirdMonthData,
                    xValueMapper: (MonthRoutine data, _) => data.routine,
                    yValueMapper: (MonthRoutine data, _) =>
                        data.avgCompletionRate),
                StackedLineSeries<MonthRoutine, String>(
                    name: months[1],
                    dataSource: _prevMonthData,
                    xValueMapper: (MonthRoutine data, _) => data.routine,
                    yValueMapper: (MonthRoutine data, _) =>
                        data.avgCompletionRate),
                StackedLineSeries<MonthRoutine, String>(
                    name: months[2],
                    dataSource: _currMonthData,
                    xValueMapper: (MonthRoutine data, _) => data.routine,
                    yValueMapper: (MonthRoutine data, _) =>
                        data.avgCompletionRate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
