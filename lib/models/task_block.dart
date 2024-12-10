class TaskBlockModel{
  String type = "taskblock";
  String category;
  int duration;
  TaskBlockModel({
    required this.category,
    required this.duration,
    required this.type
  });

  TaskBlockModel.fromJson(Map<String, Object?> json):
    this(
      type: json['type']! as String,
      duration: json['duration']! as int,
      category: json['category']! as String,
    );
  TaskBlockModel copyWith({
    String? type,
    int? duration,
    String? category
  }){
    return TaskBlockModel(type:"taskblock",duration:this.duration,category:this.category);
  }

  Map<String, Object> toJson(){
    return{
      'type': type,
      'duration': duration,
      'category': category
    };
  }
}