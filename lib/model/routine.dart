import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Routine {
  final DocumentReference? docRef;
  final String name;
  final dynamic icon;
  final Color color;
  final int numActivities;

  Routine({
    this.docRef,
    required this.name,
    required this.icon,
    required this.color,
    required this.numActivities,
  });

  Routine.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : docRef = doc.reference,
        name = doc.data()!["name"],
        icon = doc.data()!["icon"],
        color = Color(doc.data()!["color"]),
        numActivities = doc.data()!["numActivities"];
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

class DailyAverage {
  final String day;
  final double completionRate;

  DailyAverage(
    this.day,
    this.completionRate,
  );
}
