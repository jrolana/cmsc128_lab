import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:cmsc128_lab/data/statistics_data.dart';

class WeeklyRoutineList extends StatefulWidget {
  const WeeklyRoutineList({super.key});

  @override
  State<WeeklyRoutineList> createState() => _WeeklyRoutineListState();
}

class _WeeklyRoutineListState extends State<WeeklyRoutineList> {
  @override
  Widget build(BuildContext context) {
    List<WeeklyRoutineCard> routines = dailyData.map((entry) {
      return WeeklyRoutineCard(
        name: entry.name,
        avgCompletionRate: entry
            .dailyCompletionRate, // NOTE: Doesn't make sense but acts as dummy data for now
        color: entry.color,
      );
    }).toList();

    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Top Routines",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
          ),
          const SizedBox(height: 10),
          Column(
            children: routines,
          ),
        ]));
  }
}

class WeeklyRoutineCard extends StatelessWidget {
  const WeeklyRoutineCard({
    super.key,
    required this.name,
    required this.avgCompletionRate,
    required this.color,
  });

  final String name;
  final double avgCompletionRate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(IconlyBold.bag_2),
        trailing: CircularProgressIndicator(
          value: avgCompletionRate,
          valueColor: AlwaysStoppedAnimation(color),
          backgroundColor: Colors.white,
        ),
        iconColor: color,
        title: Text(name),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.lexendDeca().fontFamily),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
