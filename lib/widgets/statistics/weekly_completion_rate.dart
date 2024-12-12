import 'package:cmsc128_lab/service/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:cmsc128_lab/widgets/no_fetched_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' show log;

class WeeklyRoutineChart extends StatefulWidget {
  const WeeklyRoutineChart({super.key, required this.date});

  final DateTime date;

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
          FutureBuilder<List<RoutineAverage>>(
              future: DatabaseService.getDailyAvgCompletionRate(widget.date),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const NoFetchedData();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const FetchingData();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoFetchedData();
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
                    palette: const <Color>[
                      StyleColor.primary,
                      StyleColor.accentYellow,
                      StyleColor.accentBlue,
                      StyleColor.secondary,
                      StyleColor.accentPink,
                    ],
                    series: <CartesianSeries>[
                      ColumnSeries<RoutineAverage, String>(
                        dataSource: snapshot.data,
                        xValueMapper: (RoutineAverage data, _) => data.name,
                        yValueMapper: (RoutineAverage data, _) =>
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
