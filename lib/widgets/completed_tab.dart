import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/helpers/snack_bar.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/services/todo_service.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_card.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;
  final List<Todo> inCompletedTodos;

  const CompletedTab({
    super.key,
    required this.completedTodos,
    required this.inCompletedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
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
        widget.completedTodos.remove(todo);
        widget.inCompletedTodos.add(updatedTodo);
      });

      AppHelpers.showSnackBar(context, "Todo marked as undone");

      AppRouter.router.go("/todos");
    } catch (err) {
      print(err.toString());
      AppHelpers.showSnackBar(context, "Failed to marked as undone");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTodos.sort((a, b) => a.time.compareTo(b.time));
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: AppConstants.kDefaultHeight * 2),
          Expanded(
            child: ListView.builder(
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index) {
                final todo = widget.completedTodos[index];
                return Dismissible(
                  key: Key(todo.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      widget.completedTodos.removeAt(index);
                      TodoService().deleteTodo(todo);
                    });

                    AppHelpers.showSnackBar(
                      context,
                      "Todo deleted successfully",
                    );
                  },
                  child: TodoCard(
                    toDo: todo,
                    isComplete: true,
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
    );
  }
}
