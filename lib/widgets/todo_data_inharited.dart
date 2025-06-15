import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';

class TodoData extends InheritedWidget {
  final List<Todo> todos;
  final Function() onTodosChanged;

  const TodoData({
    super.key,
    required this.todos,
    required this.onTodosChanged,
    required super.child,
  });

  static TodoData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoData>();
  }

  @override
  bool updateShouldNotify(covariant TodoData oldWidget) {
    //print('updateShouldNotify');
    return todos != oldWidget.todos;
  }
}
