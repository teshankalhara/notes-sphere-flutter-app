import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NotesSphere", style: AppTextStyles.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: []),
      ),
    );
  }
}
