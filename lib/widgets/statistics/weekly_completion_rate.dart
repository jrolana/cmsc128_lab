import 'package:cmsc128_lab/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklyRoutineChart extends StatelessWidget {
  const WeeklyRoutineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> indices = List.generate(3, (index) => index);

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
            child: StreamBuilder<List<WeekRoutine>>(
                stream: DatabaseService.retrieveWeekRoutines(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const FetchingData();
                  }

                  return SfCartesianChart(
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
                      textStyle: TextStyle(
                          fontFamily: GoogleFonts.lexendDeca().fontFamily),
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
                        // name: routineNames[i],
                        dataSource: snapshot.data,
                        xValueMapper: (WeekRoutine data, _) => data.day,
                        yValueMapper: (WeekRoutine data, _) =>
                            data.routineCompletionRates[i],
                        pointColorMapper: (WeekRoutine data, _) =>
                            data.routineColors[i],
                        width: 0.2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      );
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
