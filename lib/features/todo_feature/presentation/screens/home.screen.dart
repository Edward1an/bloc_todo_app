import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/screens/add_task.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new task"),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddTaskScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadedState) {
            final uuid = const Uuid();
            return Center(
              child: Column(
                children: [
                  Text("tasks are loaded ${state.tasks.length}"),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TaskBloc>().add(
                            TaskSaved(
                              Task(
                                uuid.v4(),
                                "test",
                                false,
                                DateTime.now(),
                              ),
                            ),
                          );
                    },
                    child: const Text("add task"),
                  ),
                ],
              ),
            );
          }
          return const Placeholder();
        },
        listener: (context, state) {
          if (state is TaskErrorState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Unknown error"),
              ),
            );
          } else if (state is TaskNoDataState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No data"),
              ),
            );
          }
        },
      ),
    );
  }
}
