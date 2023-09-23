import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/feature/todo_feature/presentation/bloc/todo_bloc.dart';

class PopupMenuItemWidget extends StatelessWidget {
  const PopupMenuItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<TodoBloc>(context);
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'Пункт 1':
            authBloc.add(SortTrueTasksEvent());
          case 'Пункт 2':
            authBloc.add(SortFalseTasksEvent());
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Пункт 1',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Выполненые задачи'),
              Icon(Icons.circle, color: Colors.green),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Пункт 2',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Не выполненые задачи'),
              Icon(Icons.circle, color: Colors.red),
            ],
          ),
        ),
      ],
      icon: const Icon(Icons.more_vert), // Иконка с тремя вертикальными точками
    );
  }
}
