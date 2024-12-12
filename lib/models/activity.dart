class Activity {
  String type ;
  String name;
  int icon;
  int duration;
  String category;
  int order;// in seconds


  Activity({
    required this.type,
    required this.name,
    required this.icon,
    required this.duration,
    required this.category,
    required this.order
  });

  Activity.fromJson(Map<String, Object?> json) :
        this(
          type: json['type']! as String,
          name: json['name']! as String,
          icon: json['icon']! as int,
          duration: json['duration']! as int,
          category: json['category']! as String,
          order: json['order'] as int
      );

  Activity copyWith({
    String? type,
    String? name,
    int? icon,
    int? duration,
    String? category,
    int? order
  }) {
    return Activity(order:this.order,type:this.type,name: this.name, icon: this.icon, duration: this.duration, category: this.category);
  }
  Map<String,Object> toJson(){
    return{
      'order':order,
      'type': type,
      'name': name,
      'icon': icon,
      'duration': duration,
      'category': category
    };
  }
}