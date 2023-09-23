import 'package:dartz/dartz.dart';
import 'package:todotest/core/error_journal/error_journal.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
