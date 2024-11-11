import 'package:bloc_todo_app/core/dependency_injection.dart';
import 'package:bloc_todo_app/core/resources/data_state.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/delete_task.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/edit_task.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/get_all_tasks.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/save_task.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitState()) {
    on<TasksGotAll>(_onTasksGotAll);
    on<TaskDeleted>(_onTaskDeleted);
    on<TaskSaved>(_onTaskSaved);
    on<TaskEdited>(_onTaskEdited);
  }

  Future<void> _onTasksGotAll(
    TasksGotAll event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadingState());
    final response = await getIt<GetAllTasksUseCase>()(null);
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
    emit(TaskLoadingState());
    final response = await getIt<DeleteTaskUseCase>()(event.task);
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      emit(TaskLoadedState([responseData]));
    } else {
      emit(TaskErrorState());
    }
  }

  Future<void> _onTaskSaved(
    TaskSaved event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadingState());
    final response = await getIt<SaveTaskUseCase>()(event.task);
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      emit(TaskLoadedState([responseData]));
    } else {
      emit(TaskErrorState());
    }
  }

  Future<void> _onTaskEdited(
    TaskEdited event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadingState());
    final response = await getIt<EditTaskUseCase>()(event.task);
    if (response is DataSuccess) {
      final responseData = response.data;
      if (responseData == null) {
        emit(TaskNoDataState());
        return;
      }
      emit(TaskLoadedState([responseData]));
    } else {
      emit(TaskErrorState());
    }
  }
}
