import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part "task.model.g.dart";

@Collection(ignore: {"props"})
class TaskModel extends Equatable {
  final Id autoId = Isar.autoIncrement;
  @Index(unique: true)
  final String taskId;
  final String taskText;
  final bool isComplete;
  final DateTime createdAt;

  const TaskModel({
    required this.taskId,
    required this.taskText,
    required this.isComplete,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [taskId, taskText, isComplete, createdAt];
}
