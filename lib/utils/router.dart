import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_sphere_flutter_app/screens/home_screen.dart';
import 'package:notes_sphere_flutter_app/screens/note_by_category.dart';
import 'package:notes_sphere_flutter_app/screens/notes_screen.dart';
import 'package:notes_sphere_flutter_app/screens/todo_screen.dart';

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
    ],
  );
}
