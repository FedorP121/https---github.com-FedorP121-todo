import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/core/use_case/use_case.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_read.dart';
import 'package:todotest/feature/todo_feature/domain/repository/repository.dart';

@injectable
class LoadTasks extends UseCase<List<TasksForRead>, NoParams> {
  final TasksRepository tasksRepository;
  LoadTasks({
    required this.tasksRepository,
  });
  @override
  Future<Either<Failure, List<TasksForRead>>> call(NoParams params) async {
    return await tasksRepository.loadTasks();
  }
}
