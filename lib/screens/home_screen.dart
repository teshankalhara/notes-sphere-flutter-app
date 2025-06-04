import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';
import 'package:notes_sphere_flutter_app/widgets/notes_todo_card.dart';
import 'package:notes_sphere_flutter_app/widgets/progress_card.dart';

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
        child: Column(
          children: [
            SizedBox(height: AppConstants.kDefaultHeight),
            ProgressCard(completedTasks: 2, totalTasks: 3),
            SizedBox(height: AppConstants.kDefaultHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: NotesTodoCard(
                    title: 'Notes',
                    description: "Notes Notes Notes Notes Notes",
                    icon: Icons.bookmark_add_outlined,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todo");
                  },
                  child: NotesTodoCard(
                    title: 'To-Do List',
                    description: "Notes Notes Notes Notes Notes",
                    icon: Icons.today_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstants.kDefaultHeight * 3),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Progress", style: AppTextStyles.appSubtitle),
                Text("See All", style: AppTextStyles.appButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
