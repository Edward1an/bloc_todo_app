import 'package:bloc_todo_app/features/todo_feature/data/repositories/task.repository_impl.dart';
import 'package:bloc_todo_app/features/todo_feature/data/services/isar.service.dart';
import 'package:bloc_todo_app/features/todo_feature/data/sources/local/local_task.source.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/repositories/task.repository.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/delete_task.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/edit_task.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/get_all_tasks.usecase.dart';
import 'package:bloc_todo_app/features/todo_feature/domain/usecases/save_task.usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies() async {
  await _registerIsarDatabase();
  _registerSources();
  _registerRepositories();
  _registerUseCases();
  _registerBlocs();
}

Future<void> _registerIsarDatabase() async {
  final dbService = IsarService();
  await dbService.initializeIsar();
  getIt.registerSingleton<IsarService>(dbService);
}

void _registerSources() {
  getIt.registerSingleton<LocalTaskSource>(LocalTaskSource());
}

void _registerRepositories() {
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localTaskSource: getIt<LocalTaskSource>()),
  );
}

void _registerUseCases() {
  final taskRepositoryInstance = getIt<TaskRepository>();
  getIt.registerLazySingleton<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(taskRepository: taskRepositoryInstance),
  );
  getIt.registerLazySingleton<SaveTaskUseCase>(
    () => SaveTaskUseCase(taskRepository: taskRepositoryInstance),
  );
  getIt.registerLazySingleton<EditTaskUseCase>(
    () => EditTaskUseCase(taskRepository: taskRepositoryInstance),
  );
  getIt.registerLazySingleton<GetAllTasksUseCase>(
    () => GetAllTasksUseCase(taskRepository: taskRepositoryInstance),
  );
}

void _registerBlocs() {}
