

part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskDeleted extends TaskEvent {
  final Task task;
  const TaskDeleted(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskEdited extends TaskEvent {
  final Task task;
  const TaskEdited(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskSaved extends TaskEvent {
  final Task task;
  const TaskSaved(this.task);

  @override
  List<Object?> get props => [task];
}

class TasksGotAll extends TaskEvent {
  const TasksGotAll();

  @override
  List<Object?> get props => [];
}


