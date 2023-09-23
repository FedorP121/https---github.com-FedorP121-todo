import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:todotest/core/use_case/use_case.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_read.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_update.dart';
import 'package:todotest/feature/todo_feature/domain/entities/task_for_write.dart';
import 'package:todotest/feature/todo_feature/domain/use_case/delete_tasks.dart';
import 'package:todotest/feature/todo_feature/domain/use_case/load_tasks.dart';
import 'package:todotest/feature/todo_feature/domain/use_case/update_task.dart';
import 'package:todotest/feature/todo_feature/domain/use_case/write_tasks.dart';

part 'todo_event.dart';
part 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final DeleteTask deleteTask;
  final LoadTasks loadTasks;
  final UpdateTasks updateTasks;
  final WriteTasks writeTasks;
  final List<TasksForRead> _tasks = [];

  TodoBloc(
    this.deleteTask,
    this.loadTasks,
    this.updateTasks,
    this.writeTasks,
  ) : super(TodoInitial()) {
    on<LoadTasksEvent>(_loadTasks);
    on<WriteTasksEvent>(_writeTasks);
    on<DeleteTasksEvent>(_deleteTasks);
    on<UpdateTaskEvent>(_updateTask);
    on<SortTrueTasksEvent>(_sortedTrueTasks);
    on<SortFalseTasksEvent>(_sortedFalseTrueTasks);
  }

  _loadTasks(LoadTasksEvent event, Emitter emit) async {
    _tasks.clear();
    emit(LoadingTaskState());
    final either = await loadTasks.call(NoParams());
    either.fold(
      (error) => emit(ErrorTaskState(error: error)),
      (tasks) {
        _tasks.addAll(tasks);
        print('длина списка ${_tasks.length}');

        emit(LoadedTaskState(tasks: tasks));
      },
    );
  }

  _writeTasks(WriteTasksEvent event, Emitter emit) async {
    final nameTask = event.task;
    final order = event.order;
    emit(LoadingTaskState());
    if (nameTask.isNotEmpty && order != null && order >= 0) {
      final TaskForWrite task = TaskForWrite(order: order, title: nameTask);
      final either = await writeTasks.call(task);
      either.fold(
        (error) => emit(ErrorTaskState(error: error)),
        (active) => emit(SuccessfullyLoadedTaskState()),
      );
    } else {
      emit(ErrorTaskState(error: 'Введите данные'));
    }
  }

  _deleteTasks(DeleteTasksEvent event, Emitter emit) async {
    final id = event.id;
    final either = await deleteTask.call(id);
    either.fold(
      (error) => emit(ErrorTaskState(error: error)),
      (active) {
        // Удаление задачи из списка
        _tasks.removeWhere((element) => element.id == id);

        emit(LoadingTaskState());

        emit(LoadedTaskState(tasks: _tasks));
      },
    );
  }

  _updateTask(UpdateTaskEvent event, Emitter emit) async {
    final id = event.id;
    final completed = event.completed;
    final either =
        await updateTasks.call(TaskForUpdate(id: id, completed: !completed));
    either.fold(
      (error) => emit(ErrorTaskState(error: error)),
      (active) => {
        _tasks.firstWhere((task) => task.id == id).completed = !completed,
        emit(LoadingTaskState()),
        emit(LoadedTaskState(tasks: _tasks))
      },
    );
  }

  _sortedTrueTasks(SortTrueTasksEvent event, Emitter emit) async {
    _tasks.sort((a, b) {
      if (a.completed && !b.completed) return -1;
      if (!a.completed && b.completed) return 1;
      return 0;
    });
    emit(LoadingTaskState());
    emit(LoadedTaskState(tasks: _tasks));
  }

  _sortedFalseTrueTasks(SortFalseTasksEvent event, Emitter emit) async {
    _tasks.sort((a, b) {
      if (!a.completed && b.completed) return -1;
      if (a.completed && !b.completed) return 1;
      return 0;
    });
    emit(LoadingTaskState());
    emit(LoadedTaskState(tasks: _tasks));
  }
}
