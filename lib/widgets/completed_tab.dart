import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;

  const CompletedTab({super.key, required this.completedTodos});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Completed", style: AppTextStyles.appTitle));
  }
}
