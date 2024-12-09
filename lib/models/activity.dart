//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Activity {
  String name;
  String icon;
  int duration; // in seconds

  Activity({
    required this.name,
    required this.icon,
    required this.duration
  });

  Activity.fromJson(Map<String, Object?> json) :
        this(
          name: json['name']! as String,
          icon: json['icon']! as String,
          duration: json['duration']! as int
      );

  Activity copyWith({
    String? name,
    String? icon,
    int? duration,
  }) {
    return Activity(name: this.name, icon: this.icon, duration: this.duration);
  }
  Map<String,Object> toJson(){
    return{
      'name': name,
      'icon': icon,
      'duration': duration
    };
  }
}