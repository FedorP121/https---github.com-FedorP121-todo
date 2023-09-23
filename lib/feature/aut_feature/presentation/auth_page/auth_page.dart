import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/core/auto_route/auto_route.dart';
import 'package:todotest/feature/aut_feature/presentation/bloc/auth_bloc.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>()..add(CheckPasswordEvent());

    TextEditingController savePassController = TextEditingController();
    TextEditingController readPassController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Авторизация'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: authBloc,
            builder: (context, state) {
              if (state is CleanPasswordBoxState) {
                return Column(
                  children: [
                    TextField(
                      controller: savePassController,
                      decoration: const InputDecoration(
                        labelText: 'Создайте пароль',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Запись'),
                      onPressed: () => authBloc.add(WritePasswordEvent(
                          password: savePassController.text)),
                    ),
                  ],
                );
              }

              if (state is CheckPasswordBoxState) {
                return Column(
                  children: [
                    TextField(
                      controller: readPassController,
                      decoration: const InputDecoration(
                        labelText: 'Введите свой пароль',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Войти'),
                      onPressed: () => authBloc.add(
                        LoginPasswordEvent(password: readPassController.text),
                      ),
                    ),
                  ],
                );
              }
              if (state is BadPasswordBoxState) {
                return Column(
                  children: [
                    TextField(
                      controller: readPassController,
                      decoration: const InputDecoration(
                        labelText: 'Введите свой пароль',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Войти'),
                      onPressed: () => authBloc.add(
                        LoginPasswordEvent(password: readPassController.text),
                      ),
                    ),
                    const Text('Не верный пароль')
                  ],
                );
              }
              if (state is FinishLoginState) {
                AutoRouter.of(context).replace(const TodoTasksRoute());
              }

              if (state is ErrorSecureState) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error.toString())),
                  );
                });
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
