import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:iconly/iconly.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';

class DailyRoutineList extends StatefulWidget {
  const DailyRoutineList({super.key});

  @override
  State<DailyRoutineList> createState() => _DailyRoutineListState();
}

class _DailyRoutineListState extends State<DailyRoutineList> {
  @override
  Widget build(BuildContext context) {
    List<DailyRoutineCard> routines = dailyData.map((entry) {
      // TASK: Only create widgets only those that are not yet started
      return DailyRoutineCard(
        name: entry.name,
        numActivities: entry.numActivities,
        color: entry.color,
      );
    }).toList();

    int routineLen = routines.length;

    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Your Routines",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.lexendDeca().fontFamily),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(
                  maxWidth: 50,
                ),
                decoration: const BoxDecoration(
                  color: Color(0XFFEEE9FF),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$routineLen",
                  style: TextStyle(
                      color: StyleColor.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.lexendDeca().fontFamily),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: routines,
          ),
        ]));
  }
}

class DailyRoutineCard extends StatelessWidget {
  const DailyRoutineCard({
    super.key,
    required this.name,
    required this.numActivities,
    required this.color,
  });

  final String name;
  final int numActivities;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(IconlyBold.bag_2),
        iconColor: color,
        title: Text(name),
        subtitle: Text("$numActivities activities"),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.lexendDeca().fontFamily),
        subtitleTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontFamily: GoogleFonts.lexendDeca().fontFamily),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
