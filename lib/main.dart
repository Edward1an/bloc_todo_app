import 'package:bloc_todo_app/core/dependency_injection.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/screens/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (create) => TaskBloc()
            ..add(
              const TasksGotAll(),
            ),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
