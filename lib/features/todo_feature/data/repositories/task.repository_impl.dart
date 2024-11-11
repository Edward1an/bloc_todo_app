import 'package:bloc_todo_app/core/resources/data_state.dart';
import 'package:bloc_todo_app/features/todo_feature/data/mappers/task.mapper.dart';
import 'package:bloc_todo_app/features/todo_feature/data/sources/local/local_task.source.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/repositories/task.repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalTaskSource localTaskSource;

  TaskRepositoryImpl({required this.localTaskSource});

  @override
  Future<DataState<Task>> deleteTask(Task task) async {
    final response = await localTaskSource.deleteTask(TaskMapper.toModel(task));
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        return const DataFailure("responseData is empty", 500);
      }
      return DataSuccess(TaskMapper.toEntity(responseData));
    } else if (response is DataFailure) {
      return DataFailure(
        response.message ?? "Unknown error",
        response.statusCode ?? 500,
      );
    } else {
      return const DataFailure("Unexpected error", 500);
    }
  }

  @override
  Future<DataState<Task>> editTask(Task task) async {
    final response = await localTaskSource.editTask(TaskMapper.toModel(task));
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        return const DataFailure("responseData is empty", 500);
      }
      return DataSuccess(TaskMapper.toEntity(responseData));
    } else if (response is DataFailure) {
      return DataFailure(
        response.message ?? "Unknown error",
        response.statusCode ?? 500,
      );
    } else {
      return const DataFailure("Unexpected error", 500);
    }
  }

  @override
  Future<DataState<List<Task>>> getAllTasks() async {
    final response = await localTaskSource.geAllTasks();
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        return const DataFailure("responseData is empty", 500);
      }

      return DataSuccess(
        responseData.map((e) => TaskMapper.toEntity(e)).toList(),
      );
    } else if (response is DataFailure) {
      return DataFailure(
        response.message ?? "Unknown error",
        response.statusCode ?? 500,
      );
    } else {
      return const DataFailure("Unexpected error", 500);
    }
  }

  @override
  Future<DataState<Task>> saveTask(Task task) async {
    final response = await localTaskSource.saveTask(TaskMapper.toModel(task));
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        return const DataFailure("responseData is empty", 500);
      }
      return DataSuccess(TaskMapper.toEntity(responseData));
    } else if (response is DataFailure) {
      return DataFailure(
        response.message ?? "Unknown error",
        response.statusCode ?? 500,
      );
    } else {
      return const DataFailure("Unexpected error", 500);
    }
  }
}
