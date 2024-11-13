import 'package:flutter/material.dart';
import 'package:cmsc128_lab/utils/styles.dart';

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

List<Color> routineColors = [
  StyleColor.primary,
  StyleColor.secondary,
  StyleColor.accentBlue,
  StyleColor.accentPink,
  StyleColor.accentOrange,
];

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

List<DayRoutine> dailyData = routineData.map((routine) {
  counter = counter + 1;
  return DayRoutine(
    routine.name,
    routine.numActivities,
    routine.color,
    counter + 50,
  );
}).toList();

final List<WeekRoutine> weeklyData = [
  WeekRoutine("Sn", completionRates[0], routineColors),
  WeekRoutine("M", completionRates[1], routineColors),
  WeekRoutine("T", completionRates[2], routineColors),
  WeekRoutine("W", completionRates[3], routineColors),
  WeekRoutine("Th", completionRates[4], routineColors),
  WeekRoutine("F", completionRates[5], routineColors),
  WeekRoutine("S", completionRates[6], routineColors),
];
