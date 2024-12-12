class Routine {
  String docID;
  int color;
  String name;
  int numActivities;
  double repeatDaysCount;
  double repeatWeeksCount;
  List daysOfWeek;

  Routine({
    this.docID = "",
    required this.color,
    required this.name,
    required this.numActivities,
    required this.repeatDaysCount,
    required this.repeatWeeksCount,
    required this.daysOfWeek,});

  Routine.fromJson(Map<String, Object?> json) :
        this(
          docID: json['docID']! as String,
          color: json['color']! as int,
          name: json['name']! as String,
          numActivities: json['numActivities']! as int,
          repeatDaysCount: json['repeatDaysCount']! as double,
          repeatWeeksCount: json['repeatWeeksCount']! as double,
          daysOfWeek: json['daysOfWeek']! as List
      );

  Routine copyWith({
    String? docID,
    int? color,
    String? name,
    int? numActivities,
    double? repeatDaysCount,
    double? repeatWeeksCount,
    List? daysOfWeek
  }) {
    return Routine(
        docID: this.docID,
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
      'docID': docID,
      'color': color,
      'name': name,
      'numActivities': numActivities,
      'repeatDaysCount': repeatDaysCount,
      'repeatWeeksCount': repeatWeeksCount,
      'daysOfWeek': daysOfWeek
    };
  }
}
