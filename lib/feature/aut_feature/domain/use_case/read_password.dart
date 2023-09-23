import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/core/use_case/use_case.dart';
import 'package:todotest/feature/aut_feature/domain/repository/password_repository.dart';

@injectable
class ReadPassword implements UseCase<bool, NoParams> {
  final PasswordRepository passwordRepository;
  ReadPassword({
    required this.passwordRepository,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    return await passwordRepository.readPassword();
  }
}
