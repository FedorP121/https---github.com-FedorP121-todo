// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/feature/todo_feature/data/data_sourse/task_server.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_read.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_update.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_write.dart';
import 'package:todotest/feature/todo_feature/domain/repository/repository.dart';

@Injectable(as: TasksRepository)
class TasksRepositoryImpl implements TasksRepository {
  final TaskDataSourse taskDataSourse;
  TasksRepositoryImpl(this.taskDataSourse);

  @override
  Future<Either<Failure, bool>> deleteTask(String id) async {
    return await _deleteTask(id);
  }

  Future<Either<Failure, bool>> _deleteTask(String id) async {
    try {
      final task = await taskDataSourse.deleteTask(id);
      return Right(task);
    } on Failure catch (e) {
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure, List<TasksForRead>>> loadTasks() async {
    return await _loadTasks();
  }

  Future<Either<Failure, List<TasksForRead>>> _loadTasks() async {
    try {
      final task = await taskDataSourse.loadTasks();
      return Right(task);
    } on Failure catch (e) {
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskForUpdate task) async {
    return await _updateTask(task);
  }

  Future<Either<Failure, bool>> _updateTask(TaskForUpdate task) async {
    try {
      final truth = await taskDataSourse.updateTask(task);
      return Right(truth);
    } on Failure catch (e) {
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure, bool>> writeTask(TaskForWrite task) async {
    return await _writeTask(task);
  }

  Future<Either<Failure, bool>> _writeTask(TaskForWrite task) async {
    try {
      final truth = await taskDataSourse.writeTask(task);
      return Right(truth);
    } on Failure catch (e) {
      throw Left(ServerError(error: e));
    }
  }
}
