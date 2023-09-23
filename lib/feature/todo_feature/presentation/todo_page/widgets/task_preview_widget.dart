// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todotest/feature/todo_feature/domain/entities/task_for_read.dart';
import 'package:todotest/feature/todo_feature/presentation/bloc/todo_bloc.dart';

class TaskPreview extends StatelessWidget {
  final TasksForRead task;
  const TaskPreview({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<TodoBloc>(context);

    final nameTask = task.title;
    final order = task.order;
    final completed = task.completed;
    final id = task.id;
    return Card(
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            Icons.circle,
            color: completed ? Colors.green : Colors.red,
          ),
          onPressed: () =>
              authBloc.add(UpdateTaskEvent(id: id, completed: completed)),
        ),
        title: Text(maxLines: 1, nameTask),
        subtitle: Text(maxLines: 1, order.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => authBloc.add(DeleteTasksEvent(id: id)),
        ),
      ),
    );
  }
}
