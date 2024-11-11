import 'package:bloc_todo_app/core/resources/data_state.dart';
import 'package:bloc_todo_app/core/usecase/usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/repositories/task.repository.dart';

class GetAllTasksUseCase implements UseCase<DataState<List<Task>>, void>{
  final TaskRepository taskRepository;

  GetAllTasksUseCase({required this.taskRepository});
  @override
  Future<DataState<List<Task>>> call(void param)async{
    final result = await taskRepository.getAllTasks();
    if(result is DataSuccess){
      final resultData = result.data;
      if (resultData == null) {
        return const DataFailure("result data is null", 500);
      }
      return DataSuccess(resultData);
    } else if (result is DataFailure) {
      return DataFailure(result.message ?? "Unknown error", 500);
    } else {
      return const DataFailure("Unexpected error", 500);
    }


  }
}