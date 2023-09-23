import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_read.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_update.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_write.dart';

abstract interface class ITaskDataSourse {
  Future<List<TasksForRead>> loadTasks();
  Future<bool> writeTask(TaskForWrite task);
  Future<bool> deleteTask(String id);
  Future<bool> updateTask(TaskForUpdate task);
}

@injectable
class TaskDataSourse implements ITaskDataSourse {
  final url = 'https://csharp-todo-backend.azurewebsites.net/api/v1/todo';

  @override
  Future<List<TasksForRead>> loadTasks() async {
    final List<TasksForRead> todos = [];
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      for (var item in data) {
        final tovar = TasksForRead.fromMap(item);
        todos.add(tovar);
      }
      return todos;
    } else {
      throw Exception('Ошибка при загрузке');
    }
  }

  @override
  Future<bool> writeTask(TaskForWrite task) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': task.title,
        "order": task.order,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          'Failed to add task. Server responded with ${response.statusCode}');
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    final urlDelete = '$url/$id';

    final response = await http.delete(Uri.parse(urlDelete));

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      debugPrint(
          'Error deleting task: ${response.statusCode} ${response.body}');
      return false;
    }
  }

  @override
  Future<bool> updateTask(TaskForUpdate task) async {
    final id = task.id;
    final completed = task.completed;
    final urlUpdate = '$url/$id';

    final response = await http.patch(
      Uri.parse(urlUpdate),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'completed': completed,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update task: ${response.body}');
    }
  }
}
