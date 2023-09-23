// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorSecureState extends AuthState {
  final Object error;
  ErrorSecureState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

class CheckPasswordBoxState extends AuthState {
  @override
  List<Object?> get props => [];
}

class BadPasswordBoxState extends AuthState {
  @override
  List<Object?> get props => [];
}

class CleanPasswordBoxState extends AuthState {
  @override
  List<Object?> get props => [];
}

class FinishLoginState extends AuthState {
  final bool comparison;
  FinishLoginState({
    required this.comparison,
  });
  @override
  List<Object?> get props => [comparison];
}
