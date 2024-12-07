import 'package:flutter/material.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:intl/intl.dart';

class Routine {
  final String name;
  final int numActivities;
  final Color color;

  Routine(this.name, this.numActivities, this.color);
}

class DayRoutine extends Routine {
  final double dailyCompletionRate;

  DayRoutine(
      super.name, super.numActivities, super.color, this.dailyCompletionRate);
}

class WeekRoutine {
  final String day;
  final List<double> weeklyCompletionRates;
  final List<Color> colors;

  WeekRoutine(
    this.day,
    this.weeklyCompletionRates,
    this.colors,
  );
}

class MonthRoutine {
  final String routine;
  final double avgCompletionRate; // holds current and previus month values

  MonthRoutine(
    this.routine,
    this.avgCompletionRate,
  );
}

List<Color> routineColors = [
  StyleColor.primary,
  StyleColor.secondary,
  StyleColor.accentBlue,
  StyleColor.accentPink,
  StyleColor.accentOrange,
];

/*
  Weekday | Routine1 | Routine2 | Routine3 | ...
 */
List<List<double>> completionRates = [
  [26, 8, 30, 20, 6],
  [6, 75, 4, 3, 2],
  [3, 5, 6, 45, 1],
  [4, 54, 3, 5, 21],
  [30, 13, 7, 6, 8],
  [4, 40, 3, 1, 28],
  [4, 40, 3, 1, 28],
];

List<Routine> routineData = [
  Routine(
    'Routine 1',
    10,
    routineColors[0],
  ),
  Routine(
    'Routine 2',
    3,
    routineColors[1],
  ),
  Routine(
    'Routine 3',
    7,
    routineColors[2],
  ),
  Routine(
    'Routine 4',
    2,
    routineColors[3],
  ),
  Routine(
    'Routine 5',
    5,
    routineColors[4],
  ),
];

int counter = 0;

List<int> routineIndices = List.generate(routineData.length, (index) => index);

List<DayRoutine> dailyData = routineIndices.map((i) {
  return DayRoutine(
    routineData[i].name,
    routineData[i].numActivities,
    routineData[i].color,
    counter + 50,
  );
}).toList();

List<String> weekdays = ["Sn", "M", "T", "W", "Th", "F", "S"];

DateTime currMonth = DateTime.now();
DateTime prevMonth = currMonth.subtract(const Duration(days: 31));
DateTime prevPrevMonth = prevMonth.subtract(const Duration(days: 31));

List<String> months = [
  DateFormat.LLLL().format(prevPrevMonth),
  DateFormat.LLLL().format(prevMonth),
  DateFormat.LLLL().format(currMonth),
];

List<int> weekIndices = List.generate(weekdays.length, (index) => index);

List<WeekRoutine> weeklyData = weekIndices.map((i) {
  return WeekRoutine(weekdays[i], completionRates[i], routineColors);
}).toList();

List<MonthRoutine> prevMonthData = routineIndices.map((i) {
  double total = 0;

  for (int j = 0; j < routineData.length; j++) {
    total += completionRates[i][j];
  }

  double avgCompletionRate = total / completionRates.length;

  return MonthRoutine(routineData[i].name, avgCompletionRate);
}).toList();

List<MonthRoutine> currMonthData = routineIndices.map((i) {
  double total = 0;

  for (int j = 0; j < routineData.length; j++) {
    total += completionRates[i][j] - 5;
  }

  double avgCompletionRate = total / completionRates.length;

  return MonthRoutine(routineData[i].name, avgCompletionRate);
}).toList();

List<MonthRoutine> thirdMonthData = routineIndices.map((i) {
  double total = 0;

  for (int j = 0; j < routineData.length; j++) {
    total += completionRates[i][j] - 10;
  }

  double avgCompletionRate = total / completionRates.length;

  return MonthRoutine(routineData[i].name, avgCompletionRate);
}).toList();
