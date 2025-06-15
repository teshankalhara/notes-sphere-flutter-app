import 'package:hive/hive.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';

class TodoService {
  List<Todo> todos = [
    Todo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: true,
    ),
    Todo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  //create db ref for todos
  final _myBox = Hive.box("todos");

  //check user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //if new user init todos
  Future<void> createInitialTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("TODOS", todos);
    }
  }

  //load todos
  Future<List<Todo>> loadTodos() async {
    final dynamic todoList = _myBox.get("TODOS");
    if (todoList != null && todoList is List<dynamic>) {
      return todoList.cast<Todo>().toList();
    }
    return [];
  }
}
