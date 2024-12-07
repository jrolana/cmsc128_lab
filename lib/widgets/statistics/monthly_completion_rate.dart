import 'package:cmsc128_lab/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:cmsc128_lab/utils/time.dart';
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
  List<RoutineAverage> currMonthData = [];
  List<RoutineAverage> prevMonthData = [];
  List<RoutineAverage> prevPrevMonthData = [];

  @override
  void initState() {
    super.initState();

    DateTime currDate = DateTime.now();
    DateTime currMonth = DateTime.utc(currDate.year, currDate.month, 1);
    DateTime prevMonth = DateTime.utc(currDate.year, currDate.month - 1, 1);
    DateTime prevPrevMonth = DateTime.utc(currDate.year, currDate.month - 2, 1);

    DatabaseService.getMonthlyAverageCompletionRate(currMonth).then((data) {
      setState(() {
        currMonthData = data;
      });
    });

    DatabaseService.getMonthlyAverageCompletionRate(prevMonth).then((data) {
      setState(() {
        prevMonthData = data;
      });
    });

    DatabaseService.getMonthlyAverageCompletionRate(prevPrevMonth).then((data) {
      setState(() {
        prevPrevMonthData = data;
      });
    });
  }

  // Prevents setState() called after dispose()
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
                StackedLineSeries<RoutineAverage, String>(
                    name: months[0],
                    dataSource: currMonthData,
                    xValueMapper: (RoutineAverage data, _) => data.name,
                    yValueMapper: (RoutineAverage data, _) =>
                        data.completionRate),
                StackedLineSeries<RoutineAverage, String>(
                    name: months[1],
                    dataSource: prevMonthData,
                    xValueMapper: (RoutineAverage data, _) => data.name,
                    yValueMapper: (RoutineAverage data, _) =>
                        data.completionRate),
                StackedLineSeries<RoutineAverage, String>(
                    name: months[2],
                    dataSource: prevPrevMonthData,
                    xValueMapper: (RoutineAverage data, _) => data.name,
                    yValueMapper: (RoutineAverage data, _) =>
                        data.completionRate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
