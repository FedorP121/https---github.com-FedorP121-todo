import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/core/auto_route/auto_route.dart';
import 'package:todotest/feature/todo_feature/presentation/bloc/todo_bloc.dart';

@RoutePage()
class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<TodoBloc>(context);
    TextEditingController newTask = TextEditingController();
    TextEditingController newOrder = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавить задачу'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: newTask,
                decoration: const InputDecoration(
                  labelText: 'Текст задачи',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: newOrder,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: 'Номер задачи',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<TodoBloc, TodoState>(
                bloc: authBloc,
                builder: (context, state) {
                  if (state is SuccessfullyLoadedTaskState) {
                    authBloc.add(LoadTasksEvent());
                    AutoRouter.of(context).pop(const TodoTasksRoute());
                  }

                  if (state is LoadingTaskState) {
                    return ElevatedButton(
                      child: const CircularProgressIndicator(),
                      onPressed: () {},
                    );
                  }

                  return ElevatedButton(
                    child: const Text('Записать'),
                    onPressed: () {
                      authBloc.add(WriteTasksEvent(
                          task: newTask.text, order: int.parse(newOrder.text)));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
