import 'package:equatable/equatable.dart';

class TaskForUpdate extends Equatable {
  final bool completed;
  final String id;
  const TaskForUpdate({
    required this.completed,
    required this.id,
  });

  @override
  List<Object> get props => [completed, id];
}
