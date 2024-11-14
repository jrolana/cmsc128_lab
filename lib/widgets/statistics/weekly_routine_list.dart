import 'package:flutter/material.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';
import 'package:cmsc128_lab/widgets/routine_card.dart';
import 'package:cmsc128_lab/widgets/title_with_icon.dart';
import 'package:iconly/iconly.dart';
import 'package:cmsc128_lab/utils/styles.dart';

int topLen = 3;

class TopWeeklyRoutineList extends StatefulWidget {
  const TopWeeklyRoutineList({super.key});

  @override
  State<TopWeeklyRoutineList> createState() => _TopWeeklyRoutineListState();
}

class _TopWeeklyRoutineListState extends State<TopWeeklyRoutineList> {
  @override
  Widget build(BuildContext context) {
    int n = dailyData.length > topLen ? topLen : dailyData.length - 1;

    List<RoutineCard> routines = dailyData.sublist(0, n).map((entry) {
      return RoutineCard(
        name: entry.name,
        numActivities: entry.numActivities,
        avgCompletionRate: entry.dailyCompletionRate /
            100, // NOTE: Doesn't make sense but acts as dummy data for now
        color: entry.color,
      );
    }).toList();

    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const TitleWithIcon(
            text: "Top Routines",
            icon: Icon(size: 13, color: StyleColor.gold, IconlyBold.star),
            iconBgColor: Color.fromARGB(255, 255, 247, 198),
          ),
          const SizedBox(height: 10),
          Column(
            children: routines,
          ),
        ]));
  }
}

class BottomWeeklyRoutineList extends StatefulWidget {
  const BottomWeeklyRoutineList({super.key});

  @override
  State<BottomWeeklyRoutineList> createState() => _BottomWeeklyRoutineList();
}

class _BottomWeeklyRoutineList extends State<BottomWeeklyRoutineList> {
  @override
  Widget build(BuildContext context) {
    // NOTE: dailyData should already be sorted
    int n = dailyData.length - 1;
    late dynamic routines;

    if (n > 3) {
      routines = dailyData.sublist(n - 3, n).map((entry) {
        return RoutineCard(
          name: entry.name,
          numActivities: entry.numActivities,

          avgCompletionRate: entry.dailyCompletionRate /
              100, // NOTE: Doesn't make sense but acts as dummy data for now
          color: entry.color,
        );
      }).toList();
    } else {
      routines = const Text("No routines yet");
    }

    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TitleWithIcon(
            text: "Routines to Focus On",
            icon: const Icon(size: 12, color: Colors.red, IconlyBold.work),
            iconBgColor: Colors.red[50]!,
          ),
          const SizedBox(height: 10),
          Column(
            children: routines,
          ),
        ]));
  }
}
