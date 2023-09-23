import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/core/auto_route/auto_route.dart';
import 'package:todotest/core/servise_locator/servise_lacator.dart';
import 'package:todotest/feature/aut_feature/presentation/bloc/auth_bloc.dart';
import 'package:todotest/feature/todo_feature/presentation/bloc/todo_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<TodoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'TodoTest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerDelegate: AutoRouterDelegate(_appRouter),
        routeInformationParser:
            _appRouter.defaultRouteParser(includePrefixMatches: true),
      ),
    );
  }
}
