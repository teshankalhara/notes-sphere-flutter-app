import 'package:uuid/uuid.dart';

class Note {
  final String id;
  final String title;
  final String category;
  final String content;
  final DateTime date;

  Note({
    String? id,
    required this.title,
    required this.category,
    required this.content,
    required this.date,
  }) : id = id ?? const Uuid().v4();
}
