import 'package:dartz/dartz.dart';
import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/feature/aut_feature/domain/entities/password.dart';

abstract interface class PasswordRepository {
  Future<Either<Failure, bool>> writePassword(Password password);

  Future<Either<Failure, bool>> readPassword();

  Future<Either<Failure, bool>> loginPassword(Password password);
}
