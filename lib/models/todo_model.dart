import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final DateTime date;
  final DateTime time;
  final bool isDone;

  Todo({
    String? id,
    required this.title,
    required this.date,
    required this.time,
    required this.isDone,
  }) : id = id ?? const Uuid().v4();
}
