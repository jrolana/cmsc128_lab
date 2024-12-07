import 'package:cmsc128_lab/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:cmsc128_lab/widgets/routine_card.dart';
import 'package:cmsc128_lab/widgets/title_with_icon.dart';
import 'dart:developer' show log;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class DailyRoutineList extends StatelessWidget {
  const DailyRoutineList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: StreamBuilder<List<DayRoutine>>(
            stream: DatabaseService.getDayRoutines(),
            builder: (context, snapshot) {
              int routineLen = 0;
              dynamic routineCards;

              if (snapshot.hasData) {
                var routines = snapshot.data!;
                routineLen = routines.length;

                routineCards = routines.map((entry) {
                  log(entry.name);

                  return RoutineCard(
                    name: entry.name,
                    numActivities: entry.numActivities!,
                    completionRate: entry.completionRate!,
                    color: entry.color,
                  );
                }).toList();
              } else {
                routineCards = [
                  const FetchingData(),
                ];
              }

              return Column(children: [
                TitleWithIcon(
                  text: "Your Routines",
                  icon: Text(
                    "$routineLen",
                    style: TextStyle(
                        color: StyleColor.primary,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily),
                  ),
                  iconBgColor: const Color(0XFFEEE9FF),
                ),
                const SizedBox(height: 10),
                Column(
                  children: routineCards,
                ),
              ]);
            }));
  }
}
