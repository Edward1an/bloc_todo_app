import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;
  final int index;

  const TaskDetailsScreen({
    required this.index,
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.taskText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          margin: const EdgeInsets.all(40),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Time created: ${DateFormat.yMMMMd().format(task.createdAt)}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoadedState) {
                      return Switch.adaptive(
                        value: state.tasks[index].isComplete,
                        onChanged: (value) {
                          context.read<TaskBloc>().add(
                                TaskIsCompleteChanged(
                                  state.tasks[index],
                                  value,
                                ),
                              );
                        },
                      );
                    }
                    return const Switch.adaptive(
                      value: false,
                      onChanged: null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
