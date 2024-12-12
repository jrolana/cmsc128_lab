import 'package:cmsc128_lab/widgets/statistics/weekly_completion_rate.dart';
import 'package:cmsc128_lab/widgets/statistics/weekly_routine_list.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:cmsc128_lab/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'dart:developer' show log;

class StatisticsWeekly extends StatefulWidget {
  const StatisticsWeekly({super.key});

  @override
  State<StatisticsWeekly> createState() => _StatisticsWeeklyState();
}

class _StatisticsWeeklyState extends State<StatisticsWeekly> {
  // Dummy data for demo purpose
  final DateTime now = DateTime.utc(2024, 11, 23);

  final int duration = 6;
  late DateTime _startDate;
  late DateTime _endDate;
  late String _timeframe;
  late DateTime _timeConstraint;
  late DateTime _draftTime;

  @override
  void initState() {
    super.initState();

    _startDate = Time.getWeekStart(now);
    _endDate = Time.addDays(_startDate, duration);
    _updateTimeframe();
  }

  void _goPrevWeek() {
    _timeConstraint = Time.subtractDays(Time.getWeekStart(now), duration * 3);
    _draftTime = Time.subtractDays(_startDate, duration);

    if (_draftTime.isAfter(_timeConstraint)) {
      setState(() {
        _startDate = Time.getWeekStart(_draftTime);
        _endDate = Time.addDays(_startDate, duration);
      });
    }
  }

  void _goNextWeek() {
    _timeConstraint = Time.addDays(Time.getWeekStart(now), duration * 3);
    _draftTime = Time.addDays(_startDate, duration + 1);

    if (_draftTime.isBefore(_timeConstraint)) {
      setState(() {
        _startDate = Time.getWeekStart(_draftTime);
        _endDate = Time.addDays(_startDate, duration);
      });
    }
  }

  void _updateTimeframe() {
    setState(() {
      _timeframe =
          "${DateFormat('MMM d').format(_startDate)} - ${DateFormat('MMM d').format(_endDate)}";

      if (_startDate == _endDate) {
        _timeframe = DateFormat('MMM d').format(_startDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    _goPrevWeek();
                    _updateTimeframe();
                  },
                  icon: const Icon(
                    IconlyBold.arrow_left_2,
                    color: Colors.black54,
                  )),
              Text(
                _timeframe,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.lexendDeca().fontFamily),
              ),
              IconButton(
                  onPressed: () {
                    _goNextWeek();
                    _updateTimeframe();
                  },
                  icon: const Icon(
                    IconlyBold.arrow_right_2,
                    color: Colors.black54,
                  )),
            ],
          ),
        ),
        WeeklyRoutineChart(date: _startDate),
        WeeklyRoutineList(
          isTop: true,
          title: "Top Routines",
          iconColor: StyleColor.gold,
          iconBgColor: const Color.fromARGB(255, 255, 247, 198),
          date: _startDate,
        ),
        WeeklyRoutineList(
          isTop: false,
          title: "Routines to Focus On",
          iconColor: Colors.red,
          iconBgColor: Colors.red[50]!,
          date: _startDate,
        ),
      ],
    );
  }
}
