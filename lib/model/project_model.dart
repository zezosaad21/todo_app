import 'package:todo_app/model/task_model.dart';

class Project {
  late final id;
  final String name;
  final String startTime;
  final String endTime;
  final String description;
  final String status;

  Project({
    this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.status,
  });


  Map<String, dynamic> toMap(){
    return {
      //'id' : id,
      'name' : name,
      'description' : description,
      'startTime' : startTime,
      'endTime' : endTime,
      'status': status,
    };
  }

  @override
  String toString() {

    return 'Task{id: $id, name: $name, description: $description,startTime: $startTime , endTime: $endTime, status: $status}';
  }
}
