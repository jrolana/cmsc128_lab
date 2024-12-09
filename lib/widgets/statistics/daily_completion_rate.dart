import 'package:cmsc128_lab/service/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyCompletionRate extends StatelessWidget {
  const DailyCompletionRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Routine Completion Rate",
            textAlign: TextAlign.left,
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
            child: StreamBuilder<List<DayRoutine>>(
                stream: DatabaseService.getDayRoutines(DateTime.utc(2024, 11, 23)),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const FetchingData();
                  }

                  return SfCircularChart(
                    margin: const EdgeInsets.all(20),
                    title: ChartTitle(
                        text:
                            'Your today\'s routines are almost done—keep it up!',
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily)),
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      position: LegendPosition.right,
                      textStyle: TextStyle(
                          fontFamily: GoogleFonts.lexendDeca().fontFamily),
                    ),
                    series: <CircularSeries>[
                      RadialBarSeries<DayRoutine, String>(
                        useSeriesColor: true,
                        trackOpacity: 0.1,
                        dataSource: snapshot.data,
                        sortingOrder: SortingOrder.ascending,
                        sortFieldValueMapper: (DayRoutine data, _) =>
                            data.completionRate,
                        xValueMapper: (DayRoutine data, _) => data.name,
                        yValueMapper: (DayRoutine data, _) =>
                            data.completionRate,
                        pointColorMapper: (DayRoutine data, _) => data.color,
                        maximumValue: 100,
                        radius: '100%',
                        cornerStyle: CornerStyle.bothCurve,
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
