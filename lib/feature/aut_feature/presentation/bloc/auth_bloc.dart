import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:todotest/core/use_case/use_case.dart';
import 'package:todotest/feature/aut_feature/domain/entities/password.dart';
import 'package:todotest/feature/aut_feature/domain/use_case/login_password.dart';
import 'package:todotest/feature/aut_feature/domain/use_case/read_password.dart';
import 'package:todotest/feature/aut_feature/domain/use_case/write_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ReadPassword checkPassword;
  final WritePassword writePassword;
  final LoginAcount loginPerson;
  AuthBloc({
    required this.checkPassword,
    required this.writePassword,
    required this.loginPerson,
  }) : super(AuthInitial()) {
    on<WritePasswordEvent>(_writePasswordEvent);
    on<CheckPasswordEvent>(_readPasswordEvent);
    on<LoginPasswordEvent>(_loginEvent);
  }

  _writePasswordEvent(WritePasswordEvent event, Emitter emit) async {
    if (event.password.isNotEmpty) {
      final Password password = Password(password: event.password);
      final checkPassword = await writePassword.call(password);
      checkPassword.fold((error) {
        debugPrint(error.toString());
        emit(ErrorSecureState(error: error));
      }, (r) {
        debugPrint('пароль есть');
        emit(CheckPasswordBoxState());
      });
    } else {
      emit(ErrorSecureState(error: 'Поле для пароля пустое'));
    }
  }

  _readPasswordEvent(CheckPasswordEvent event, Emitter emit) async {
    final chekPassword = await checkPassword.call(NoParams());
    chekPassword.fold((error) {
      debugPrint(error.toString());
      emit(ErrorSecureState(error: error));
    }, (password) {
      if (password == false) {
        debugPrint('пароля нет');
        emit(CleanPasswordBoxState());
      } else {
        debugPrint('пароль есть');
        emit(CheckPasswordBoxState());
      }
    });
  }

  _loginEvent(LoginPasswordEvent event, Emitter emit) async {
    if (event.password.isNotEmpty) {
      final Password password = Password(password: event.password);
      final chekPassword = await loginPerson.call(password);

      chekPassword.fold((error) {
        debugPrint(error.toString());
        emit(ErrorSecureState(error: 'Не верный пароль'));
      }, (comparison) {
        if (comparison == true) {
          debugPrint('ваш пароль верный');
          emit(FinishLoginState(comparison: comparison));
        } else if (comparison == false) {
          debugPrint('ваш пароль не верный');
          emit(BadPasswordBoxState());
        }
      });
    } else {
      emit(BadPasswordBoxState());
    }
  }
}
