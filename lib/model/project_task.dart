class TaskProject {
  late final id;
  final String title;
  final String description;
  final String time;
  final String status;
  final int projectId;



  TaskProject({
    required this.title,
    required this.description,
    required this.time,
    required this.status,
    required this.projectId,
    this.id,
  });

  Map<String, dynamic> toMap(){
    return {
      //'id' : id,
      'title' : title,
      'description' : description,
      'time' : time,
      'status': status,
    };
  }

  @override
  String toString() {

    return 'Task{id: $id, title: $title, description: $description, time: $time, status: $status}';
  }
}
