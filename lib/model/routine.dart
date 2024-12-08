import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Routine {
  final DocumentReference? docRef;
  final String name;
  final dynamic icon;
  final Color color;
  final int numActivities;
  final double? repeatWeeksCount;
  final double? repeatDaysCount;

  Routine({
    this.docRef,
    required this.name,
    required this.icon,
    required this.color,
    required this.numActivities,
    this.repeatWeeksCount,
    this.repeatDaysCount,
  });

  Routine.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : docRef = doc.reference,
        name = doc.data()!["name"],
        icon = doc.data()!["icon"],
        color = Color(doc.data()!["color"]),
        numActivities = doc.data()!["numActivities"],
        repeatWeeksCount = doc.data()!["repeatWeeksCount"],
        repeatDaysCount = doc.data()!["repeatDaysCount"];
}

class DayRoutine extends Routine {
  final double? completionRate;

  DayRoutine({
    required super.name,
    required super.icon,
    required super.color,
    required super.numActivities,
    this.completionRate,
  });
}

class RoutineAverage {
  final String name;
  final double completionRate;

  RoutineAverage(
    this.name,
    this.completionRate,
  );
}
