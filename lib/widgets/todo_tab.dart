import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';

class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("To-Do", style: AppTextStyles.appTitle));
  }
}
