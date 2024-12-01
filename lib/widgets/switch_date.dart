import 'package:cmsc128_lab/utils/time.dart';
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
  late DateTime _startDate;
  late DateTime _endDate;
  late String _timeframe;

  @override
  void initState() {
    _startDate = Time.getWeekStart(DateTime.now());
    _endDate = Time.addDays(_startDate, 6);
    _timeframe =
        "${DateFormat('MMM d').format(_startDate)} - ${DateFormat('MMM d').format(_endDate)}";
    if (_startDate == _endDate) {
      _timeframe = DateFormat('MMM d').format(_startDate);
    }
    super.initState();
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
            _timeframe,
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
