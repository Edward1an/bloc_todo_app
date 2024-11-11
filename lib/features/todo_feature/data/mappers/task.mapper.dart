import 'package:bloc_todo_app/features/todo_feature/data/models/task.model.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';

class TaskMapper {
  static Task toEntity(TaskModel taskModel) {
    return Task(
      taskModel.taskId,
      taskModel.taskText,
      taskModel.isComplete,
      taskModel.createdAt,
    );
  }

  static TaskModel toModel(Task task) {
    return TaskModel(
      taskId: task.taskId,
      taskText: task.taskText,
      isComplete: task.isComplete,
      createdAt: task.createdAt,
    );
  }
}
