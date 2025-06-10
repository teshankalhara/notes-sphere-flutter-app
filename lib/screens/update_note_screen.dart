import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Note note;

  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Edit Note")));
  }
}
