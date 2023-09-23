import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/core/use_case/use_case.dart';

import 'package:todotest/feature/todo_feature/domain/entities/task_for_write.dart';
import 'package:todotest/feature/todo_feature/domain/repository/repository.dart';

@injectable
class WriteTasks extends UseCase<bool, TaskForWrite> {
  final TasksRepository tasksRepository;
  WriteTasks({
    required this.tasksRepository,
  });
  @override
  Future<Either<Failure, bool>> call(TaskForWrite task) async {
    return await tasksRepository.writeTask(task);
  }
}
