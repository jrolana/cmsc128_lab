import 'package:cmsc128_lab/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' show log;

class WeeklyRoutineChart extends StatefulWidget {
  const WeeklyRoutineChart({super.key});

  @override
  State<WeeklyRoutineChart> createState() => _WeeklyRoutineChartState();
}

class _WeeklyRoutineChartState extends State<WeeklyRoutineChart> {
  @override
  Widget build(BuildContext context) {
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
          FutureBuilder<List<DailyAverage>>(
              future: DatabaseService.getDailyAvgCompletionRate(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const FetchingData();
                }

                return Container(
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
                    // legend: Legend(
                    //   isVisible: false,
                    // ),
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
                    palette: <Color>[
                      StyleColor.primary,
                      StyleColor.accentYellow,
                      StyleColor.accentBlue,
                      StyleColor.secondary,
                      StyleColor.accentPink,
                    ],
                    series: <CartesianSeries>[
                      ColumnSeries<DailyAverage, String>(
                        dataSource: snapshot.data,
                        xValueMapper: (DailyAverage data, _) => data.day,
                        yValueMapper: (DailyAverage data, _) =>
                            data.completionRate,
                        width: 0.2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
