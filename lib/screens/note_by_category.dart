import 'package:flutter/material.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/services/note_service.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';
import 'package:notes_sphere_flutter_app/widgets/note_category_card.dart';

class NoteByCategory extends StatefulWidget {
  final String category;

  const NoteByCategory({super.key, required this.category});

  @override
  State<NoteByCategory> createState() => _NoteByCategoryState();
}

class _NoteByCategoryState extends State<NoteByCategory> {
  final NoteService noteService = NoteService();
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  //load all notes by category
  Future<void> _loadNotesByCategory() async {
    noteList = await noteService.getNotesByCategoryName(widget.category);
    setState(() {
      // Update the state with the loaded notes
      //print(noteList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.category),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //go to the notes page
            AppRouter.router.push("/notes");
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstants.kDefaultHeight),
              Text(widget.category, style: AppTextStyles.appTitle),
              const SizedBox(height: AppConstants.kDefaultHeight),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return NoteCategoryCard(
                    noteContent: noteList[index].content,
                    noteTitle: noteList[index].title,
                    editNote: () async {},
                    removeNote: () async {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
