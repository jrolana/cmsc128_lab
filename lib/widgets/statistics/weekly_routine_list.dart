import 'package:flutter/material.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';
import 'package:cmsc128_lab/widgets/routine_card.dart';
import 'package:cmsc128_lab/widgets/title_with_icon.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklyRoutineList extends StatefulWidget {
  const WeeklyRoutineList({
    super.key,
    required this.isTop,
    required this.title,
    required this.iconColor,
    required this.iconBgColor,
  });

  final String title;
  final Color iconColor;
  final Color iconBgColor;
  final bool isTop;

  @override
  State<WeeklyRoutineList> createState() => _WeeklyRoutineListState();
}

class _WeeklyRoutineListState extends State<WeeklyRoutineList> {
  late List<DayRoutine> _weeklyRoutines;
  dynamic _routines = [
    Text("No routines available.\nBuild more routines to see this!",
        style: TextStyle(
            fontSize: 12, fontFamily: GoogleFonts.lexendDeca().fontFamily))
  ];

  @override
  void initState() {
    _weeklyRoutines = getRoutines();
    int dataLen = _weeklyRoutines.length;
    int baseLen = 3;

    // Bottom 3 Routines
    int n = dataLen;
    int start = n - 3;

    // Ensure bottom 3 starts at 4th element if num of routines < 6
    if (dataLen < (baseLen * 2)) {
      start = 3;
    }

    // Top 3 Routines
    if (widget.isTop) {
      n = (dataLen > baseLen) ? baseLen : dataLen;
      start = 0;
    }

    if ((n - start) > 0) {
      _routines = _weeklyRoutines.sublist(start, n).map((entry) {
        return RoutineCard(
          name: entry.name,
          numActivities: entry.numActivities,
          completionRate: entry.dailyCompletionRate /
              100, // NOTE: Doesn't make sense but acts as dummy data for now
          color: entry.color,
        );
      }).toList();
    }

    super.initState();
  }

  List<DayRoutine> getRoutines() {
    return dailyData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TitleWithIcon(
              text: widget.title,
              icon: Icon(size: 13, color: widget.iconColor, IconlyBold.star),
              iconBgColor: widget.iconBgColor),
          const SizedBox(height: 10),
          Column(
            children: _routines,
          ),
        ]));
  }
}
