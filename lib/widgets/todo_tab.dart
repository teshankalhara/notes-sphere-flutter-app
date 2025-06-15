import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/helpers/snack_bar.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/services/todo_service.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_card.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_data_inharited.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> inCompletedTodos;
  final List<Todo> completedTodos;

  const TodoTab({
    super.key,
    required this.inCompletedTodos,
    required this.completedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  void _marksTodoAsDone(Todo todo) async {
    try {
      final Todo updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );
      await TodoService().markAsDone(updatedTodo);

      setState(() {
        widget.inCompletedTodos.remove(todo);
        widget.completedTodos.add(updatedTodo);
      });

      AppHelpers.showSnackBar(context, "Todo marked as done");

      AppRouter.router.go("/todos");
    } catch (err) {
      print(err.toString());
      AppHelpers.showSnackBar(context, "Failed to marked as done");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.inCompletedTodos.sort((a, b) => a.time.compareTo(b.time));
    });

    return TodoData(
      todos: widget.inCompletedTodos,
      onTodosChanged: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.kDefaultPadding),
        child: Column(
          children: [
            const SizedBox(height: AppConstants.kDefaultHeight * 2),
            Expanded(
              child: ListView.builder(
                itemCount: widget.inCompletedTodos.length,
                itemBuilder: (context, index) {
                  final todo = widget.inCompletedTodos[index];
                  return Dismissible(
                    key: Key(todo.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        widget.inCompletedTodos.removeAt(index);
                        TodoService().deleteTodo(todo);
                      });
                      AppHelpers.showSnackBar(context, "Todo deleted");
                    },
                    child: TodoCard(
                      toDo: todo,
                      isComplete: false,
                      onCheckBoxChanged: () {
                        _marksTodoAsDone(todo);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
