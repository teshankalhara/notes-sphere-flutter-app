import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/helpers/snack_bar.dart';
import 'package:notes_sphere_flutter_app/models/todo_model.dart';
import 'package:notes_sphere_flutter_app/services/todo_service.dart';
import 'package:notes_sphere_flutter_app/utils/colors.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';
import 'package:notes_sphere_flutter_app/widgets/completed_tab.dart';
import 'package:notes_sphere_flutter_app/widgets/todo_tab.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TodoService todoService = TodoService();

  late List<Todo> allTodos = [];
  late List<Todo> inCompletedTodos = [];
  late List<Todo> completedTodos = [];

  final TextEditingController _todoController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    _todoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkUserIsNew();
  }

  void _checkUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();
    //print(isNewUser);
    if (isNewUser) {
      await todoService.createInitialTodos();
    }
    await _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await todoService.loadTodos();
    setState(() {
      allTodos = loadedTodos;
      inCompletedTodos = allTodos.where((t) => !t.isDone).toList();
      completedTodos = allTodos.where((t) => t.isDone).toList();
    });
  }

  void _addTodo() async {
    try {
      if (_todoController.text.isNotEmpty) {
        final Todo newToDo = Todo(
          title: _todoController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );

        await todoService.addTodo(newToDo);

        setState(() {
          allTodos.add(newToDo);
          inCompletedTodos.add(newToDo);
        });

        AppHelpers.showSnackBar(context, "Task added successfully!");
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackBar(context, "Task added Failed!");
    }
  }

  void openMessageModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          title: Text(
            "Add Task",
            style: AppTextStyles.appDescription.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.kWhiteColor,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _todoController,
                  style: TextStyle(color: AppColors.kWhiteColor, fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Enter your task",
                    hintStyle: AppTextStyles.appDescriptionSmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _addTodo();
                AppRouter.router.go("/todos");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.kFabColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: const Text("Add Task", style: AppTextStyles.appButton),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.kWhiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppRouter.router.go("/");
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(child: Text("To-Do", style: AppTextStyles.appDescription)),
            Tab(child: Text("Completed", style: AppTextStyles.appDescription)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMessageModal(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          side: BorderSide(color: AppColors.kWhiteColor, width: 1),
        ),
        child: const Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(inCompletedTodos: allTodos, completedTodos: completedTodos),
          CompletedTab(
            completedTodos: completedTodos,
            inCompletedTodos: inCompletedTodos,
          ),
        ],
      ),
    );
  }
}
