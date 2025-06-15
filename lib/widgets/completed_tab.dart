import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_card.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;

  const CompletedTab({super.key, required this.completedTodos});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
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
                return TodoCard(
                  toDo: todo,
                  isComplete: true,
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
