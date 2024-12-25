import 'package:flutter/material.dart';

@immutable
class Todo {
  final String title;
  final String description;
  final Color color;

  const Todo({
    required this.title,
    required this.description,
    required this.color,
  });

  Todo copy({
    String? title,
    String? description,
    Color? color,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }
}
