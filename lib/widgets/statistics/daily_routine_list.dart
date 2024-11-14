import 'package:cmsc128_lab/widgets/title_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';
import 'package:cmsc128_lab/widgets/routine_card.dart';

class DailyRoutineList extends StatefulWidget {
  const DailyRoutineList({super.key});

  @override
  State<DailyRoutineList> createState() => _DailyRoutineListState();
}

class _DailyRoutineListState extends State<DailyRoutineList> {
  @override
  Widget build(BuildContext context) {
    List<RoutineCard> routines = dailyData.map((entry) {
      // TASK: Only create widgets for those that are not yet started
      return RoutineCard(
        name: entry.name,
        numActivities: entry.numActivities,
        avgCompletionRate: entry.dailyCompletionRate / 100,
        color: entry.color,
      );
    }).toList();

    int routineLen = routines.length;

    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
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
            children: routines,
          ),
        ]));
  }
}
