import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/core/auto_route/auto_route.dart';
import 'package:todotest/feature/todo_feature/presentation/bloc/todo_bloc.dart';
import 'package:todotest/feature/todo_feature/presentation/todo_page/widgets/popup_menu_item_widget.dart';

import 'widgets/task_preview_widget.dart';

@RoutePage()
class TodoTasks extends StatelessWidget {
  const TodoTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<TodoBloc>(context)..add(LoadTasksEvent());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const PopupMenuItemWidget())
        ],
        centerTitle: true,
        title: const Text('Задачи'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: 500,
          child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
            if (state is LoadingTaskState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LoadedTaskState) {
              final tasks = state.tasks;
              final count = tasks.length;

              return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks[index];
                    return TaskPreview(task: task);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: count);
            }
            if (state is ErrorTaskState) {
              return Center(
                child: Text('Произошла ошибка: ${state.error.toString()}'),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Произошла ошибка состояний'),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => authBloc.add(LoadTasksEvent()),
                    child: const Text('Перезагрузить страницу'))
              ],
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          AutoRouter.of(context).push(const AddTaskRoute());
        },
      ),
    );
  }
}
