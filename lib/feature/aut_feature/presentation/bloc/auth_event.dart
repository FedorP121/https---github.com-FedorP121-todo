// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class WritePasswordEvent extends AuthEvent {
  final String password;
  WritePasswordEvent({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}

class CheckPasswordEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginPasswordEvent extends AuthEvent {
  final String password;
  LoginPasswordEvent({
    required this.password,
  });
  @override
  List<Object?> get props => [password];
}
