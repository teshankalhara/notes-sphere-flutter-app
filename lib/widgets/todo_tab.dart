import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodos;

  const TodoTab({super.key, required this.incompletedTodos});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: AppConstants.kDefaultHeight * 2),
          Expanded(
            child: ListView.builder(
              itemCount: widget.incompletedTodos.length,
              itemBuilder: (context, index) {
                final todo = widget.incompletedTodos[index];
                return TodoCard(
                  toDo: todo,
                  isComplete: false,
                  onCheckBoxChanged: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
