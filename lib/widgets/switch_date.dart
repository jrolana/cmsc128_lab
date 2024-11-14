import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class SwitchDate extends StatefulWidget {
  const SwitchDate({super.key});

  @override
  State<SwitchDate> createState() => _SwitchDateState();
}

class _SwitchDateState extends State<SwitchDate> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    startDate = getStartDate(DateTime.now());
    endDate = startDate.add(const Duration(days: 7));
    super.initState();
  }

  DateTime getStartDate(DateTime date) {
    return DateTime(date.year, date.month, date.day - date.weekday % 7);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            IconlyBold.arrow_left_2,
            color: Colors.black54,
          ),
          Text(
            '${DateFormat('MMM d').format(startDate)} - ${DateFormat('MMM d').format(endDate)}',
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
          ),
          const Icon(
            IconlyBold.arrow_right_2,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
