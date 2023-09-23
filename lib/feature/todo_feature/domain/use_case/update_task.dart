import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/core/use_case/use_case.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_update.dart';
import 'package:todotest/feature/todo_feature/domain/repository/repository.dart';

@injectable
class UpdateTasks extends UseCase<bool, TaskForUpdate> {
  final TasksRepository tasksRepository;
  UpdateTasks({
    required this.tasksRepository,
  });
  @override
  Future<Either<Failure, bool>> call(TaskForUpdate params) async {
    return await tasksRepository.updateTask(params);
  }
}
