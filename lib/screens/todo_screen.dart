import 'package:flutter/material.dart';
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
  late List<Todo> incompletedTodos = [];
  late List<Todo> completedTodos = [];

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
      await _loadTodos();
    }
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await todoService.loadTodos();
    setState(() {
      allTodos = loadedTodos;
      incompletedTodos = allTodos.where((t) => !t.isDone).toList();
      completedTodos = allTodos.where((t) => t.isDone).toList();
    });
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
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          side: BorderSide(color: AppColors.kWhiteColor, width: 1),
        ),
        child: const Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(incompletedTodos: incompletedTodos),
          CompletedTab(completedTodos: completedTodos),
        ],
      ),
    );
  }
}
