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

class TaskIsCompleteChanged extends TaskEvent {
  final Task task;
  final bool value;

  const TaskIsCompleteChanged(this.task, this.value);

  @override
  List<Object?> get props => [task, value];
}

class TaskTextChanged extends TaskEvent {
  final Task task;
  final String newText;

  const TaskTextChanged(this.task, this.newText);

  @override
  List<Object?> get props => [task, newText];
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
