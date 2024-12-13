class Routine {
  int color;
  String name;
  int numActivities;
  num repeatDaysCount;
  num repeatWeeksCount;
  List daysOfWeek;

  Routine({
    required this.color,
    required this.name,
    required this.numActivities,
    required this.repeatDaysCount,
    required this.repeatWeeksCount,
    required this.daysOfWeek});

  Routine.fromJson(Map<String, Object?> json) :
        this(
          color: json['color']! as int,
          name: json['name']! as String,
          numActivities: json['numActivities']! as int,
          repeatDaysCount: json['repeatDaysCount']! as num,
          repeatWeeksCount: json['repeatWeeksCount']! as num,
          daysOfWeek: json['daysOfWeek']! as List
      );

  Routine copyWith({
    int? color,
    String? name,
    int? numActivities,
    num? repeatDaysCount,
    num? repeatWeeksCount,
    List? daysOfWeek
  }) {
    return Routine(
        color: this.color,
        name: this.name,
        numActivities: this.numActivities,
        repeatDaysCount: this.repeatDaysCount,
        repeatWeeksCount: this.repeatWeeksCount,
        daysOfWeek: this.daysOfWeek
    );
  }
  Map<String, Object> toJson(){
    return {
      'color': color,
      'name': name,
      'numActivities': numActivities,
      'repeatDaysCount': repeatDaysCount,
      'repeatWeeksCount': repeatWeeksCount,
      'daysOfWeek': daysOfWeek
    };
  }
}
