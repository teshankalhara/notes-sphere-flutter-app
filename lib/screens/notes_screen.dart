import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/services/note_service.dart';
import 'package:notes_sphere_flutter_app/utils/colors.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteService noteService = NoteService();
  List<Note> allNotes = [];

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNewAndCreateInitialNotes();
  }

  //check if user is new
  void _checkIfUserIsNewAndCreateInitialNotes() async {
    final bool isNewUser = await noteService.isNewUser();
    //print("Is new user: $isNewUser");
    if (isNewUser) {
      await noteService.createInitialNotes();
    }

    //load notes
    _loadNotes();
  }

  //method for loading notes
  Future<void> _loadNotes() async {
    final List<Note> notes = await noteService.loadNotes();
    setState(() {
      allNotes = notes;
      print("Notes loaded: ${allNotes.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.go("/"); //
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          side: BorderSide(color: AppColors.kWhiteColor, width: 1),
        ),
        child: const Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          children: [const Text("Notes", style: AppTextStyles.appTitle)],
        ),
      ),
    );
  }
}
