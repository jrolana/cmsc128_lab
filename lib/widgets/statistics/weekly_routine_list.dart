import 'package:cmsc128_lab/service/database_service.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/widgets/fetching_data.dart';
import 'package:cmsc128_lab/widgets/no_fetched_data.dart';
import 'package:cmsc128_lab/widgets/routine_card.dart';
import 'package:cmsc128_lab/widgets/title_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconly/iconly.dart';
import 'dart:developer' show log;

class WeeklyRoutineList extends StatefulWidget {
  const WeeklyRoutineList({
    super.key,
    required this.isTop,
    required this.title,
    required this.iconColor,
    required this.iconBgColor,
    required this.date,
  });

  final String title;
  final Color iconColor;
  final Color iconBgColor;
  final bool isTop;
  final DateTime date;

  @override
  State<WeeklyRoutineList> createState() => _WeeklyRoutineListState();
}

// top performing routines (avg. of routines across a week)
class _WeeklyRoutineListState extends State<WeeklyRoutineList> {
  late List<DayRoutine> _weeklyAvgCompletionRate;
  List<Widget> _routines = [const FetchingData()];

  @override
  void initState() {
    super.initState();

    DatabaseService.getWeeklyAverageCompletionRate(widget.date)
        .then((weeklyAvgCompletionRate) {
      SchedulerBinding.instance.addPostFrameCallback((timestamp) {
        updateRoutineList(weeklyAvgCompletionRate);
      });
    });
  }

  // To account for changes in the parent widget
  @override
  void didUpdateWidget(covariant WeeklyRoutineList oldWidget) {
    super.didUpdateWidget(oldWidget);

    DatabaseService.getWeeklyAverageCompletionRate(widget.date)
        .then((weeklyAvgCompletionRate) {
      SchedulerBinding.instance.addPostFrameCallback((timestamp) {
        updateRoutineList(weeklyAvgCompletionRate);
      });
    });
  }

  void updateRoutineList(List<DayRoutine> weeklyAvgCompletionRate) {
    setState(() {
      _weeklyAvgCompletionRate = weeklyAvgCompletionRate;

      if (_weeklyAvgCompletionRate.isEmpty) {
        _routines = [
          const NoFetchedData(),
        ];
        return;
      }

      _weeklyAvgCompletionRate.sort((a, b) =>
          (b.completionRate as num).compareTo(a.completionRate as num));
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
            completionRate: entry.completionRate! / 100,
            color: entry.color,
          );
        }).toList();
      }
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
