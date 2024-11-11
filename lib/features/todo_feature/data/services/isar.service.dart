import 'dart:io';

import 'package:bloc_todo_app/core/dependency_injection.dart';
import 'package:bloc_todo_app/features/todo_feature/data/models/task.model.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Isar isar;

  Future<void> initializeIsar() async {
    final dir = await getApplicationCacheDirectory();
    final String dbPath = join(dir.path);
    final Directory directory = Directory(dbPath);
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    isar = await Isar.open(
      [
        TaskModelSchema,
      ],
      directory: dbPath,
      name: "RepositoryIsarDB",
    );
  }

  Future<void> closeIsar() async {
    if (isar.isOpen) {
      await isar.close();
    }
  }

  Future<void> unregisterIsar() async {
    final dbService = getIt<IsarService>();
    await dbService.closeIsar();
    getIt.unregister<IsarService>();
  }
}
