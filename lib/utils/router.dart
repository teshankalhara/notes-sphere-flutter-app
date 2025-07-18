import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/screens/create_new_note.dart';
import 'package:notes_sphere_flutter_app/screens/home_screen.dart';
import 'package:notes_sphere_flutter_app/screens/note_by_category.dart';
import 'package:notes_sphere_flutter_app/screens/notes_screen.dart';
import 'package:notes_sphere_flutter_app/screens/single_note.dart';
import 'package:notes_sphere_flutter_app/screens/todo_screen.dart';
import 'package:notes_sphere_flutter_app/screens/update_note_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      //home screen
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return const HomeScreen();
        },
      ),

      //notes screen
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) {
          return const NotesScreen();
        },
      ),

      /*todos screen*/
      GoRoute(
        name: "todos",
        path: "/todos",
        builder: (context, state) {
          return const TodoScreen();
        },
      ),

      GoRoute(
        name: "category",
        path: "/category",
        builder: (context, state) {
          final String category = state.extra as String;
          return NoteByCategory(category: category);
        },
      ),

      // create new note
      GoRoute(
        name: "create-note",
        path: "/create-note",
        builder: (context, state) {
          final isNewCategoryScreen = state.extra as bool;
          return CreateNewNote(isNewCategory: isNewCategoryScreen);
        },
      ),

      //edit screen
      GoRoute(
        name: "edit-note",
        path: "/edit-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return UpdateNoteScreen(note: note);
        },
      ),

      //single note screen
      GoRoute(
        name: "single-note",
        path: "/single-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return SingleNoteScreen(note: note);
        },
      ),
    ],
  );
}
