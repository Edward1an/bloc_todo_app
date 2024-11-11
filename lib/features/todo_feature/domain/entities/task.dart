import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String taskId;
  final String taskText;
  final bool isComplete;
  final DateTime createdAt;

  const Task(this.taskId, this.taskText, this.isComplete, this.createdAt);

  @override
  List<Object?> get props => [taskId, taskText, isComplete, createdAt];
}
