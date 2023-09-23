// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/core/use_case/use_case.dart';
import 'package:todotest/feature/todo_feature/domain/repository/repository.dart';

@injectable
class DeleteTask extends UseCase<bool, String> {
  final TasksRepository tasksRepository;
  DeleteTask({
    required this.tasksRepository,
  });
  @override
  Future<Either<Failure, bool>> call(String id) async {
    return await tasksRepository.deleteTask(id);
  }
}

/*
@injectable
class LoginAcount implements UseCase<bool, Password> {
  final PasswordRepository passwordRepository;
  LoginAcount({
    required this.passwordRepository,
  });
  @override
  Future<Either<Failure, bool>> call(Password password) async {
    return await passwordRepository.loginPassword(password);
  }
}*/
