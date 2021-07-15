class Task{
  late final id;
  final String title;
  final String description;
  final String time;
  final int color;
  final String status;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.time,
    required this.status,
});

  Map<String, dynamic> toMap(){
    return {
      //'id' : id,
      'title' : title,
      'description' : description,
      'color' : color,
      'time' : time,
      'status': status,
    };
  }

  @override
  String toString() {

    return 'Task{id: $id, title: $title, description: $description,color: $color , time: $time, status: $status}';
  }
}