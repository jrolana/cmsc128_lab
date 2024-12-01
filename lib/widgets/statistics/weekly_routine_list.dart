import 'package:cmsc128_lab/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:cmsc128_lab/widgets/routine_card.dart';
import 'package:cmsc128_lab/widgets/title_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

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

// top performing routines (avg. of routines across all weeks)
class _WeeklyRoutineListState extends State<WeeklyRoutineList> {
  late List<DayRoutine> _weeklyAvgCompletionRate;
  dynamic _routines = [const FetchingData()];

  @override
  void initState() {
    DatabaseService.getWeeklyAverageCompletionRate()
        .then((weeklyAvgCompletionRate) {
      SchedulerBinding.instance.addPostFrameCallback((timestamp) {
        setState(() {
          _weeklyAvgCompletionRate = weeklyAvgCompletionRate;
          _weeklyAvgCompletionRate.sort((a, b) =>
              (b.completionRate as num)!.compareTo(a.completionRate as num));
          int dataLen = _weeklyAvgCompletionRate.length;
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
            _routines = _weeklyAvgCompletionRate.sublist(start, n).map((entry) {
              return RoutineCard(
                name: entry.name,
                numActivities: entry.numActivities,
                completionRate: entry
                    .completionRate!, // NOTE: Doesn't make sense but acts as dummy data for now
                color: entry.color,
              );
            }).toList();
          }

          if (_weeklyAvgCompletionRate.isEmpty) {
            _routines = [
              Text("No routines available.\nBuild more routines to see this!",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: GoogleFonts.lexendDeca().fontFamily))
            ];
          }
        });
      });
    });

    super.initState();
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
