import 'package:bloc_todo_app/core/dependency_injection.dart';
import 'package:bloc_todo_app/core/resources/data_state.dart';
import 'package:bloc_todo_app/features/todo_feature/data/models/task.model.dart';
import 'package:bloc_todo_app/features/todo_feature/data/services/isar.service.dart';
import 'package:isar/isar.dart';

class LocalTaskSource {
  final _isar = getIt<IsarService>().isar;
  final _storage = getIt<IsarService>().isar.collection<TaskModel>();
  

  Future<DataState<List<TaskModel>>> geAllTasks() async {
    try {
      final tasks = await _storage.where().findAll();
      return DataSuccess(tasks);
    } catch (e) {
      return DataFailure("error: $e", 500);
    }
  }

  Future<DataState<TaskModel>> saveTask(TaskModel taskModel) async {
    try {
      await _isar.writeTxn<int>(() => _storage.put(taskModel));
      return DataSuccess(taskModel);
    } catch (e) {
      return DataFailure("error: $e", 500);
    }
  }

  Future<DataState<TaskModel>> editTask(TaskModel taskModel) async {
    try {
      await _isar.writeTxn(() => _storage.put(taskModel));
      return DataSuccess(taskModel);
    } catch (e) {
      return DataFailure("error: $e", 500);
    }
  }
  
  Future<DataState<TaskModel>> deleteTask(TaskModel taskModel)async{
    try{
      await _isar.writeTxn(()=> _storage.delete(taskModel.autoId));
      return DataSuccess(taskModel);
    } catch (e){
      return DataFailure("error: $e", 500);
    }
  }
}
