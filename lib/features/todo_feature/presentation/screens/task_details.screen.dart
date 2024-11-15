import 'package:bloc_todo_app/features/todo_feature/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/task.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.taskText)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          margin: const EdgeInsets.all(40),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoadedState) {
                  final currentTask = state.tasks.firstWhere(
                    (savedTask) => savedTask.taskId == task.taskId,
                  );
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Time created: ${DateFormat.yMMMMd().format(currentTask.createdAt)}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Switch.adaptive(
                        value: currentTask.isComplete,
                        onChanged: (value) {
                          context.read<TaskBloc>().add(
                                TaskIsCompleteChanged(
                                  currentTask,
                                  value,
                                ),
                              );
                        },
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
