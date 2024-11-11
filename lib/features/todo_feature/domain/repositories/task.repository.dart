import 'package:bloc_todo_app/core/resources/data_state.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';

abstract class TaskRepository {
  Future<DataState<List<Task>>> getAllTasks();

  Future<DataState<Task>> saveTask(Task task);

  Future<DataState<Task>> editTask(Task task);

  Future<DataState<Task>> deleteTask(Task task);
}
