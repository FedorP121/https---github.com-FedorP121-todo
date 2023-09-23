// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../feature/aut_feature/data/data_sourse/secure_stogage.dart' as _i3;
import '../../feature/aut_feature/data/repositories/password_repositories.dart'
    as _i12;
import '../../feature/aut_feature/domain/repository/password_repository.dart'
    as _i11;
import '../../feature/aut_feature/domain/use_case/login_password.dart' as _i16;
import '../../feature/aut_feature/domain/use_case/read_password.dart' as _i13;
import '../../feature/aut_feature/domain/use_case/write_password.dart' as _i15;
import '../../feature/aut_feature/presentation/bloc/auth_bloc.dart' as _i17;
import '../../feature/todo_feature/data/data_sourse/task_server.dart' as _i4;
import '../../feature/todo_feature/data/repositories/task_repository.dart'
    as _i6;
import '../../feature/todo_feature/domain/repository/repository.dart' as _i5;
import '../../feature/todo_feature/domain/use_case/delete_tasks.dart' as _i9;
import '../../feature/todo_feature/domain/use_case/load_tasks.dart' as _i10;
import '../../feature/todo_feature/domain/use_case/update_task.dart' as _i7;
import '../../feature/todo_feature/domain/use_case/write_tasks.dart' as _i8;
import '../../feature/todo_feature/presentation/bloc/todo_bloc.dart' as _i14;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.SecureStorage>(() => _i3.SecureStorage());
    gh.factory<_i4.TaskDataSourse>(() => _i4.TaskDataSourse());
    gh.factory<_i5.TasksRepository>(
        () => _i6.TasksRepositoryImpl(gh<_i4.TaskDataSourse>()));
    gh.factory<_i7.UpdateTasks>(
        () => _i7.UpdateTasks(tasksRepository: gh<_i5.TasksRepository>()));
    gh.factory<_i8.WriteTasks>(
        () => _i8.WriteTasks(tasksRepository: gh<_i5.TasksRepository>()));
    gh.factory<_i9.DeleteTask>(
        () => _i9.DeleteTask(tasksRepository: gh<_i5.TasksRepository>()));
    gh.factory<_i10.LoadTasks>(
        () => _i10.LoadTasks(tasksRepository: gh<_i5.TasksRepository>()));
    gh.factory<_i11.PasswordRepository>(() =>
        _i12.PasswordRepositoryImpl(secureStorage: gh<_i3.SecureStorage>()));
    gh.factory<_i13.ReadPassword>(() =>
        _i13.ReadPassword(passwordRepository: gh<_i11.PasswordRepository>()));
    gh.factory<_i14.TodoBloc>(() => _i14.TodoBloc(
          gh<_i9.DeleteTask>(),
          gh<_i10.LoadTasks>(),
          gh<_i7.UpdateTasks>(),
          gh<_i8.WriteTasks>(),
        ));
    gh.factory<_i15.WritePassword>(() =>
        _i15.WritePassword(passwordRepository: gh<_i11.PasswordRepository>()));
    gh.factory<_i16.LoginAcount>(() =>
        _i16.LoginAcount(passwordRepository: gh<_i11.PasswordRepository>()));
    gh.factory<_i17.AuthBloc>(() => _i17.AuthBloc(
          checkPassword: gh<_i13.ReadPassword>(),
          writePassword: gh<_i15.WritePassword>(),
          loginPerson: gh<_i16.LoginAcount>(),
        ));
    return this;
  }
}
