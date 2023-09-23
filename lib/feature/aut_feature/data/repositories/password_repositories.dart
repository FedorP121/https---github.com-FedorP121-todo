// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:todotest/core/error_journal/error_journal.dart';
import 'package:todotest/feature/aut_feature/data/data_sourse/secure_stogage.dart';
import 'package:todotest/feature/aut_feature/domain/entities/password.dart';
import 'package:todotest/feature/aut_feature/domain/repository/password_repository.dart';

@Injectable(as: PasswordRepository)
class PasswordRepositoryImpl implements PasswordRepository {
  final SecureStorage secureStorage;
  PasswordRepositoryImpl({
    required this.secureStorage,
  });
  @override
  Future<Either<Failure, bool>> readPassword() async {
    return await _readPassword();
  }

  Future<Either<Failure, bool>> _readPassword() async {
    try {
      final pwModel = await secureStorage.readPassword();
      return Right(pwModel);
    } on Failure catch (e) {
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure, bool>> writePassword(Password password) async {
    return await _writePassword(password);
  }

  Future<Either<Failure, bool>> _writePassword(Password password) async {
    try {
      final pwModel = await secureStorage.writePassword(password.password);
      return Right(pwModel);
    } on Failure catch (e) {
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure, bool>> loginPassword(Password password) async {
    return await _loginPassword(password);
  }

  Future<Either<Failure, bool>> _loginPassword(Password password) async {
    try {
      final pwModel = await secureStorage.loginPassword(password);
      return Right(pwModel);
    } on Failure catch (e) {
      throw Left(ServerError(error: e));
    }
  }
}
