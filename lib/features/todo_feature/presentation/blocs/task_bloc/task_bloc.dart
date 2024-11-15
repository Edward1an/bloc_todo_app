import 'package:bloc_todo_app/core/dependency_injection.dart';
import 'package:bloc_todo_app/core/resources/data_state.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/repositories/task.repository.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/delete_task.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/edit_task.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/get_all_tasks.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/save_task.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskRepository taskRepository = getIt<TaskRepository>();

  TaskBloc() : super(TaskInitState()) {
    on<TasksGotAll>(_onTasksGotAll);
    on<TaskDeleted>(_onTaskDeleted);
    on<TaskSaved>(_onTaskSaved);
    on<TaskEdited>(_onTaskEdited);
    on<TaskIsCompleteChanged>(_onTaskIsCompletedChanged);
    on<TaskTextChanged>(_onTaskTextChanged);
  }

  Future<void> _onTasksGotAll(
    TasksGotAll event,
    Emitter<TaskState> emit,
  ) async {
    final response =
        await GetAllTasksUseCase(taskRepository: taskRepository)(null);
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      emit(TaskLoadedState(responseData));
    } else {
      emit(TaskErrorState());
    }
  }

  Future<void> _onTaskDeleted(
    TaskDeleted event,
    Emitter<TaskState> emit,
  ) async {
    List<Task> list = List.from((state as TaskLoadedState).tasks);
    final response =
        await DeleteTaskUseCase(taskRepository: taskRepository)(event.task);
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      List<Task> newList =
          list.where((e) => e.taskId != responseData.taskId).toList();
      emit(TaskLoadedState(newList));
    } else {
      emit(TaskErrorState());
    }
  }

  Future<void> _onTaskSaved(
    TaskSaved event,
    Emitter<TaskState> emit,
  ) async {
    List<Task> list = List.from((state as TaskLoadedState).tasks);
    final response =
        await SaveTaskUseCase(taskRepository: taskRepository)(event.task);
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      list.add(responseData);
      emit(TaskLoadedState(list));
    } else {
      emit(TaskErrorState());
    }
  }

  Future<void> _onTaskEdited(
    TaskEdited event,
    Emitter<TaskState> emit,
  ) async {
    List<Task> list = List.from((state as TaskLoadedState).tasks);
    final response =
        await EditTaskUseCase(taskRepository: taskRepository)(event.task);
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      List<Task> newList = [];
      for (Task task in list) {
        if (task.taskId == event.task.taskId) {
          newList = list.where((e) => e.taskId != responseData.taskId).toList()
            ..insert(list.indexOf(task), responseData);
        }
      }
      emit(TaskLoadedState(newList));
    } else {
      emit(TaskErrorState());
    }
  }

  Future<void> _onTaskIsCompletedChanged(
    TaskIsCompleteChanged event,
    Emitter<TaskState> emit,
  ) async {
    List<Task> list = List.from((state as TaskLoadedState).tasks);
    final response = await EditTaskUseCase(taskRepository: taskRepository)(
      Task(
        event.task.taskId,
        event.task.taskText,
        event.value,
        event.task.createdAt,
      ),
    );
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      List<Task> newList = [];
      for (Task task in list) {
        if (task.taskId == event.task.taskId) {
          newList = list.where((e) => e.taskId != responseData.taskId).toList()
            ..insert(list.indexOf(task), responseData);
        }
      }
      emit(TaskLoadedState(newList));
    } else {
      emit(TaskErrorState());
    }
  }

  Future<void> _onTaskTextChanged(
    TaskTextChanged event,
    Emitter<TaskState> emit,
  ) async {
    List<Task> list = List.from((state as TaskLoadedState).tasks);
    final response = await EditTaskUseCase(taskRepository: taskRepository)(
      Task(
        event.task.taskId,
        event.newText,
        event.task.isComplete,
        event.task.createdAt,
      ),
    );
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      List<Task> newList = [];
      for (Task task in list) {
        if (task.taskId == event.task.taskId) {
          newList = list.where((e) => e.taskId != responseData.taskId).toList()
            ..insert(list.indexOf(task), responseData);
        }
      }
      emit(TaskLoadedState(newList));
    } else {
      emit(TaskErrorState());
    }
  }
}
