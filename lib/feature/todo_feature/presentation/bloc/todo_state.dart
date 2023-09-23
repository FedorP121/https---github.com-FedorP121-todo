part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {}

final class TodoInitial extends TodoState {
  @override
  List<Object?> get props => [];
}

class LoadingTaskState extends TodoState {
  @override
  List<Object?> get props => [];
}

class LoadedTaskState extends TodoState {
  final List<TasksForRead> tasks;
  LoadedTaskState({
    required this.tasks,
  });
  @override
  List<Object?> get props => [tasks];
}

class ErrorTaskState extends TodoState {
  final Object error;
  ErrorTaskState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}

class SuccessfullyLoadedTaskState extends TodoState {
  @override
  List<Object?> get props => [];
}
