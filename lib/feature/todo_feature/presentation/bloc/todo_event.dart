part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {}

class LoadTasksEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class WriteTasksEvent extends TodoEvent {
  final String task;
  final int order;
  WriteTasksEvent({
    required this.task,
    required this.order,
  });

  @override
  List<Object?> get props => [task];
}

class DeleteTasksEvent extends TodoEvent {
  final String id;
  DeleteTasksEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class UpdateTaskEvent extends TodoEvent {
  final String id;
  final bool completed;
  UpdateTaskEvent({
    required this.id,
    required this.completed,
  });

  @override
  List<Object?> get props => [id, completed];
}

class SortTrueTasksEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class SortFalseTasksEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}
