import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/services/note_service.dart';
import 'package:notes_sphere_flutter_app/services/todo_service.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';
import 'package:notes_sphere_flutter_app/widgets/main_screen_todo_card.dart';
import 'package:notes_sphere_flutter_app/widgets/notes_todo_card.dart';
import 'package:notes_sphere_flutter_app/widgets/progress_card.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_data_inharited.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> allNotes = [];
  List<Todo> allTodos = [];

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
    setState(() {});
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser =
        await TodoService().isNewUser() || await NoteService().isNewUser();
    if (isNewUser) {
      await TodoService().createInitialTodos();
      await NoteService().createInitialNotes();
    }
    _loadNotes();
    _loadTodos();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await NoteService().loadNotes();
    setState(() {
      allNotes = loadedNotes;
    });
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await TodoService().loadTodos();
    setState(() {
      allTodos = loadedTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: allTodos,
      onTodosChanged: _loadTodos,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("NotesSphere", style: AppTextStyles.appTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: AppConstants.kDefaultHeight * 2),
              ProgressCard(
                completedTasks: allTodos.where((t) => t.isDone).length,
                totalTasks: allTodos.length,
              ),
              SizedBox(height: AppConstants.kDefaultHeight * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push("/notes");
                    },
                    child: NotesTodoCard(
                      title: 'Notes',
                      description: "${allNotes.length} Notes",
                      icon: Icons.bookmark_add_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push("/todos");
                    },
                    child: NotesTodoCard(
                      title: 'To-Do List',
                      description: "${allTodos.length} Todos",
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
              SizedBox(height: AppConstants.kDefaultHeight * 3),
              allTodos.isEmpty
                  ? Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "No tasks for today , Add some tasks to get started!",
                            style: AppTextStyles.appDescription.copyWith(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              AppRouter.router.push("/todos");
                            },
                            child: const Text("Add Task"),
                          ),
                        ],
                      ),
                    ),
                  )
                  : Expanded(
                    child: ListView.builder(
                      itemCount: allTodos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: MainScreenToDoCard(
                            toDoTitle: allTodos[index].title,
                            date: allTodos[index].date.toString(),
                            time: allTodos[index].time.toString(),
                            isDone: allTodos[index].isDone,
                          ),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
