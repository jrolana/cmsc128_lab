import 'package:cloud_firestore/cloud_firestore.dart';

class Routine {
  int color;
  String icon;
  String name;
  int numActivities;
  int repeatDaysCount;
  int repeatWeeksCount;

  Routine({
    required this.color,
    required this.icon,
    required this.name,
    required this.numActivities,
    required this.repeatDaysCount,
    required this.repeatWeeksCount});

  Routine.fromJson(Map<String, Object?> json) :
        this(
          color: json['color']! as int,
          icon: json['icon']! as String,
          name: json['name']! as String,
          numActivities: json['numActivities']! as int,
          repeatDaysCount: json['repeatDaysCount']! as int,
          repeatWeeksCount: json['repeatWeeksCount']! as int
      );

  Routine copyWith({
    int? color,
    String? icon,
    String? name,
    int? numActivities,
    int? repeatDaysCount,
    int? repeatWeeksCount,
  }) {
    return Routine(
        color: this.color,
        icon: this.icon,
        name: this.name,
        numActivities: this.numActivities,
        repeatDaysCount: this.repeatDaysCount,
        repeatWeeksCount: this.repeatWeeksCount
    );
  }
  Map<String, Object> toJson(){
    return {
      'color': color,
      'icon':icon,
      'name': name,
      'numActivities': numActivities,
      'repeatDaysCount': repeatDaysCount,
      'repeatWeeksCount': repeatWeeksCount
    };
  }
}
