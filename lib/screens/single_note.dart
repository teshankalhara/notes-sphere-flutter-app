import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_sphere_flutter_app/models/note_model.dart';
import 'package:notes_sphere_flutter_app/utils/colors.dart';
import 'package:notes_sphere_flutter_app/utils/constants.dart';
import 'package:notes_sphere_flutter_app/utils/text_styles.dart';

class SingleNoteScreen extends StatefulWidget {
  final Note note;

  const SingleNoteScreen({super.key, required this.note});

  @override
  State<SingleNoteScreen> createState() => _SingleNoteScreenState();
}

class _SingleNoteScreenState extends State<SingleNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(widget.note.date);

    return Scaffold(
      appBar: AppBar(title: const Text("Note")),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(widget.note.title, style: AppTextStyles.appTitle),
            const SizedBox(height: 5),
            Text(
              formattedDate,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kFabColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.note.content,
              style: AppTextStyles.appDescription.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
