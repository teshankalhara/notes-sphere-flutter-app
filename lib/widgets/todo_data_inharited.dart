import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';

class ToDoData extends InheritedWidget {
  final List<Todo> todos;
  final Function() onTodosChanged;

  const ToDoData({
    super.key,
    required this.todos,
    required this.onTodosChanged,
    required super.child,
  });

  static ToDoData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ToDoData>();
  }

  @override
  bool updateShouldNotify(covariant ToDoData oldWidget) {
    //print('updateShouldNotify');
    return todos != oldWidget.todos;
  }
}
