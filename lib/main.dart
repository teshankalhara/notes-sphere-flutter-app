import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/screens/home_screen.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NotesSphere",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
