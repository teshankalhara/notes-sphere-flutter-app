import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/services/note_service.dart';
import 'package:notes_sphere_flutter_app/utils/colors.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';
import 'package:notes_sphere_flutter_app/widgets/bottom_sheet.dart';
import 'package:notes_sphere_flutter_app/widgets/notes_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteService noteService = NoteService();
  List<Note> allNotes = [];
  Map<String, List<Note>> notesWithCategory = {};

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
    final List<Note> loadNotes = await noteService.loadNotes();
    final Map<String, List<Note>> notesByCategory = noteService
        .getNotesByCategoryMap(loadNotes);
    setState(() {
      allNotes = loadNotes;
      notesWithCategory = notesByCategory;
      //print("Notes loaded: ${allNotes.length}");
      //print("Notes by category: ${notesWithCategory}");
    });
  }

  //open bottom sheet
  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryInputBottomSheet(
          onNewNote: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: false);
          },
          onNewCategory: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: true);
          },
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
          onPressed: () {
            AppRouter.router.go("/"); //
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openBottomSheet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          side: BorderSide(color: AppColors.kWhiteColor, width: 1),
        ),
        child: const Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Notes", style: AppTextStyles.appTitle),
            const SizedBox(height: AppConstants.kDefaultHeight * 2),
            allNotes.isEmpty
                ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: Text(
                      "No notes available , click on the + button to add a new note",
                      style: TextStyle(
                        color: AppColors.kWhiteColor.withOpacity(0.7),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notesWithCategory.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppConstants.kDefaultPadding,
                    mainAxisSpacing: AppConstants.kDefaultPadding,
                    childAspectRatio: 6 / 4,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //go to notes by category
                        AppRouter.router.push(
                          "/category",
                          extra: notesWithCategory.keys.elementAt(index),
                        );
                      },
                      child: NotesCard(
                        noteCategory: notesWithCategory.keys.elementAt(index),
                        noOfNotes:
                            notesWithCategory.values.elementAt(index).length,
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
