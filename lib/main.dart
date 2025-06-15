import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/theme_data.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_data_inharited.dart';

void main() async {
  //init hive
  await Hive.initFlutter();

  //register adapters
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  //open boxes
  await Hive.openBox('notes');
  await Hive.openBox('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: [],
      onTodosChanged: () {},
      child: MaterialApp.router(
        title: "NotesSphere",
        debugShowCheckedModeBanner: false,
        theme: ThemeClass.darkTheme.copyWith(
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
