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
      await _myBox.put("todos", todos);
    }
  }

  //load todos
  Future<List<Todo>> loadTodos() async {
    final dynamic todoList = _myBox.get("todos");
    if (todoList != null && todoList is List<dynamic>) {
      return todoList.cast<Todo>().toList();
    }
    return [];
  }

  //marks todo as done
  Future<void> markAsDone(Todo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element.id == todo.id);

      allTodos[index] = todo;

      await _myBox.put("todos", allTodos);
    } catch (err) {
      print(err.toString());
    }
  }

  // Method to add a todo
  Future<void> addTodo(Todo todo) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.add(todo);
      await _myBox.put("todos", allTodos);
    } catch (e) {
      print(e);
    }
  }

  //update todo
  Future<void> updateTodo(Todo todo) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element == todo);

      allTodos[index] = todo;
      await _myBox.put("todos", allTodos);
    } catch (e) {
      print(e);
    }
  }

  //delete todo
  Future<void> deleteTodo(Todo todo) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");

      allTodos.remove(todo);
      await _myBox.put("todos", allTodos);
    } catch (e) {
      print(e);
    }
  }
}
