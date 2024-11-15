part of 'task_bloc.dart';

sealed class TaskState {}

class TaskInitState extends TaskState {}

class TaskNoDataState extends TaskState {}

class TaskErrorState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  TaskLoadedState(this.tasks);
}
