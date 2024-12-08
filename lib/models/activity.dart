class Activity {
  String name;
  int icon;
  int duration; // in seconds

  Activity({
    required this.name,
    required this.icon,
    required this.duration
  });

  Activity.fromJson(Map<String, Object?> json) :
        this(
          name: json['name']! as String,
          icon: json['icon']! as int,
          duration: json['duration']! as int
      );

  Activity copyWith({
    String? name,
    int? icon,
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