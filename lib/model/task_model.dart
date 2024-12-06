import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String? task;
  @HiveField(1)
  String? desc;
  @HiveField(2)
  String? date;
  @HiveField(3)
  String? time;
  TaskModel({
    required this.task,
    required this.desc,
    required this.date,
    required this.time,
  });
}
