import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_sphere_flutter_app/helpers/snack_bar.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/services/note_service.dart';
import 'package:notes_sphere_flutter_app/utils/colors.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/router.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';
import 'package:uuid/uuid.dart';

class CreateNewNote extends StatefulWidget {
  final bool isNewCategory;

  const CreateNewNote({super.key, required this.isNewCategory});

  @override
  State<CreateNewNote> createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {
  List<String> categories = [];
  final NoteService noteService = NoteService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitileController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCategoryController = TextEditingController();

  String category = "";

  @override
  void dispose() {
    _noteTitileController.dispose();
    _noteContentController.dispose();
    _noteCategoryController.dispose();
    super.dispose();
  }

  Future _loadCategories() async {
    categories = await noteService.getAllCategories();
    setState(() {
      //print(categories.length);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Note", style: AppTextStyles.appSubtitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppConstants.kDefaultHeight * 3),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding / 2,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Category Input or Dropdown
                    widget.isNewCategory
                        ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: _noteCategoryController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a category';
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: AppColors.kWhiteColor,
                              fontFamily: GoogleFonts.outfit().fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              hintText: 'New Category',
                              hintStyle: TextStyle(
                                color: AppColors.kWhiteColor.withOpacity(0.5),
                                fontFamily: GoogleFonts.outfit().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.kDefaultPadding,
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.kWhiteColor.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.kDefaultPadding,
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.kWhiteColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        )
                        : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: AppColors.kWhiteColor,
                              fontFamily: GoogleFonts.outfit().fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            isExpanded: false,
                            hint: const Text('Category'),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.kDefaultPadding,
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.kWhiteColor.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.kDefaultPadding,
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.kWhiteColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            items:
                                categories.map((String category) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.centerLeft,
                                    value: category,
                                    child: Text(
                                      category,
                                      style: AppTextStyles.appButton,
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                category = value!;
                              });
                            },
                          ),
                        ),

                    const SizedBox(height: AppConstants.kDefaultHeight * 3),

                    // Note Title
                    TextFormField(
                      controller: _noteTitileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
                      ), // Set text color to white
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ), // Set hint text color to white
                        border: InputBorder.none, // Remove all borders
                      ),
                    ),

                    const SizedBox(height: AppConstants.kDefaultHeight * 2),

                    // Note Content
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter note content';
                        }
                        return null;
                      },
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ), // Set hint text color to white
                        border: InputBorder.none, // Remove all borders
                      ),
                    ),

                    const SizedBox(height: AppConstants.kDefaultHeight * 3),

                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),

                    const SizedBox(height: AppConstants.kDefaultHeight),

                    // Save Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //save note
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteService.addNote(
                                  Note(
                                    id: const Uuid().v4(),
                                    title: _noteTitileController.text,
                                    category:
                                        widget.isNewCategory
                                            ? _noteCategoryController.text
                                            : category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                  ),
                                );

                                //show success message
                                AppHelpers.showSnackBar(
                                  context,
                                  "Note saved successfully!",
                                );

                                _noteCategoryController.clear();
                                _noteTitileController.clear();
                                _noteContentController.clear();

                                AppRouter.router.push("/notes");
                              } catch (err) {
                                print(err.toString());
                                AppHelpers.showSnackBar(
                                  context,
                                  "Failed to save note!",
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.kFabColor,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          child: Text(
                            "Save Note",
                            style: AppTextStyles.appButton,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
