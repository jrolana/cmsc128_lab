class Routine {
  int color;
  String icon;
  String name;
  int numActivities;
  int repeatDaysCount;
  int repeatWeeksCount;
  List daysOfWeek;

  Routine({
    required this.color,
    required this.icon,
    required this.name,
    required this.numActivities,
    required this.repeatDaysCount,
    required this.repeatWeeksCount,
    required this.daysOfWeek});

  Routine.fromJson(Map<String, Object?> json) :
        this(
          color: json['color']! as int,
          icon: json['icon']! as String,
          name: json['name']! as String,
          numActivities: json['numActivities']! as int,
          repeatDaysCount: json['repeatDaysCount']! as int,
          repeatWeeksCount: json['repeatWeeksCount']! as int,
          daysOfWeek: json['daysOfWeek']! as List
      );

  Routine copyWith({
    int? color,
    String? icon,
    String? name,
    int? numActivities,
    int? repeatDaysCount,
    int? repeatWeeksCount,
    List? daysOfWeek
  }) {
    return Routine(
        color: this.color,
        icon: this.icon,
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
      'icon':icon,
      'name': name,
      'numActivities': numActivities,
      'repeatDaysCount': repeatDaysCount,
      'repeatWeeksCount': repeatWeeksCount,
      'daysOfWeek': daysOfWeek
    };
  }
}
