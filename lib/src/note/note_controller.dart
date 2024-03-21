import 'package:flutter/material.dart';
import 'package:notes_app_prototype/src/note/note_model.dart';
import 'package:notes_app_prototype/src/note/note_service.dart';

class NoteController {
  NoteController({
    this.noteUpdating,
  });

  final NoteModel? noteUpdating;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late NoteModel note = noteUpdating ?? NoteModel();

  Future<bool> submit(BuildContext context) async {
    bool isValid = formKey.currentState!.validate();
    note.lastEdited = DateTime.now().toUtc();
    NavigatorState navigator = Navigator.of(context);

    if (!isValid) {
      // TODO error handling code
    }

    formKey.currentState!.save();

    bool? isSuccessful;

    if (noteUpdating == null) {
      isSuccessful = await NoteService.addNote(note);
    } else {
      isSuccessful = await NoteService.updateNote(note);
    }

    if (isSuccessful) {
      navigator.pop();
    }

    return isSuccessful;
  }
}
