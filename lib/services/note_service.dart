import 'package:hive/hive.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  List<Note> allNotes = [
    Note(
      id: const Uuid().v4(),
      title: "Meeting Notes",
      category: "Work",
      content:
          "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Grocery List",
      category: "Personal",
      content:
          "Bought milk, eggs, bread, fruits, and vegetables from the local grocery store. Also added some snacks for the week.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Book Recommendations",
      category: "Hobby",
      content:
          "Recently read 'Sapiens' by Yuval Noah Harari, which offered fascinating insights into the history of humankind. Also enjoyed 'Atomic Habits' by James Clear, a practical guide to building good habits and breaking bad ones.",
      date: DateTime.now(),
    ),
  ];

  // create the db reference for notes
  final _myBox = Hive.box('notes');

  //check weather user is new
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // method to create init notes if box is empty
  Future<void> createInitialNotes() async {
    if (_myBox.isEmpty) {
      await _myBox.put("notes", allNotes);
    }
  }

  //method to load notes
  Future<List<Note>> loadNotes() async {
    final dynamic notes = await _myBox.get("notes");
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<Note>().toList();
    }
    return [];
  }

  //get notes by category
  Map<String, List<Note>> getNotesByCategoryMap(List<Note> allNotes) {
    final Map<String, List<Note>> notesByCategory = {};
    for (final note in allNotes) {
      if (notesByCategory.containsKey(note.category)) {
        notesByCategory[note.category]!.add(note);
      } else {
        notesByCategory[note.category] = [note];
      }
    }
    return notesByCategory;
  }

  //method to get notes acording to the category
  Future<List<Note>> getNotesByCategoryName(String category) async {
    final dynamic allNotes = await _myBox.get("notes");
    final List<Note> notes = [];

    for (final note in allNotes) {
      if (note.category == category) {
        notes.add(note);
      }
    }
    return notes;
  }
}
