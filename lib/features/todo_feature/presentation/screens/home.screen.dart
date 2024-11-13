import 'package:bloc_todo_app/features/todo_feature/domain/entities/task.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/screens/add_task.screen.dart';
import 'package:bloc_todo_app/features/todo_feature/presentation/screens/task_details.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
              final newTask = await Navigator.of(context).push<Task>(
                MaterialPageRoute(
                  builder: (_) => const AddTaskScreen(),
                ),
              );
              if (newTask == null) {
                return;
              }
              context.read<TaskBloc>().add(TaskSaved(newTask));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadedState) {
            final tasksList = state.tasks.reversed.toList();
            return Center(
              child: tasksList.isEmpty
                  ? const Text("There is no tasks\nCreate a new task!")
                  : CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: tasksList.length,
                            (BuildContext context, int index) {
                              final task = tasksList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Theme.of(context)
                                      .cardColor
                                      .withBlue(1300),
                                  child: ListTile(
                                    title: Text(
                                      task.taskText,
                                      style: TextStyle(
                                        fontStyle: task.isComplete
                                            ? FontStyle.italic
                                            : FontStyle.normal,
                                        decoration: task.isComplete
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    subtitle: Text(
                                      DateFormat.yMd().format(
                                        task.createdAt,
                                      ),
                                    ),
                                    onTap: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              TaskDetailsScreen(task: task, index: index),
                                        ),
                                      );
                                    },
                                    leading: Checkbox.adaptive(
                                      value: task.isComplete,
                                      onChanged: (value) {
                                        if (value == null) {
                                          return;
                                        }
                                        context.read<TaskBloc>().add(
                                              TaskIsCompleteChanged(
                                                task,
                                                value,
                                              ),
                                            );
                                      },
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _editTaskText(task, context);
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<TaskBloc>()
                                                .add(TaskDeleted(task));
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            );
          }
          return const SizedBox.shrink();
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

  _editTaskText(Task task, BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final newText = await showAdaptiveDialog<String>(
      context: context,
      builder: (cxt) {
        return AlertDialog.adaptive(
          title: const Text("new task text"),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isEmpty ||
                    controller.text.trim() == "") {
                  return;
                }
                Navigator.of(context).pop(controller.text);
              },
              child: const Text("Submit", style: TextStyle(fontWeight: FontWeight.w700),),
            ),
          ],
          content: Card(
            child: TextField(
              controller: controller,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "new task text",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        );
      },
    );
    if (newText == null) {
      return;
    }
    context.read<TaskBloc>().add(TaskTextChanged(task, newText));
  }
}
