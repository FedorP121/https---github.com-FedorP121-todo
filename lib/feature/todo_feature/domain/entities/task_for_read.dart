// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TasksForRead extends Equatable {
  final String id;
  bool completed;
  final int order;
  final String title;
  final String url;
  TasksForRead({
    required this.id,
    required this.completed,
    required this.order,
    required this.title,
    required this.url,
  });

  @override
  List<Object> get props {
    return [
      id,
      completed,
      order,
      title,
      url,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'completed': completed,
      'order': order,
      'title': title,
      'url': url,
    };
  }

  factory TasksForRead.fromMap(Map<String, dynamic> map) {
    return TasksForRead(
      id: map['id'] as String,
      completed: map['completed'] as bool,
      order: map['order'] as int,
      title: map['title'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksForRead.fromJson(String source) =>
      TasksForRead.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
