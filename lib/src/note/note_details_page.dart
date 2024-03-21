import 'package:flutter/material.dart';
import 'package:notes_app_prototype/src/note/note_controller.dart';
import 'package:notes_app_prototype/src/note/note_model.dart';
import 'package:notes_app_prototype/src/templates/textformfield_template.dart';

class NoteDetailsPage extends StatefulWidget {
  const NoteDetailsPage({
    super.key,
    this.note,
  });

  final NoteModel? note;
  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  late NoteController controller;
  late NoteModel note = widget.note ??
      NoteModel(); // Not the best solution, but works

  @override
  void initState(){
    super.initState();
    if (widget.note == null) {
      controller = NoteController();
    } else {
      controller = NoteController(noteUpdating: widget.note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            note.id == null
                ? 'Criando nova nota'
                : 'Editando nota ${note.id}',
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Form(
                key: controller.formKey,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        'Criado em: ${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year} às ${note.createdAt.hour}h${note.createdAt.minute}min',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Última edição: ${note.lastEdited.day}/${note.lastEdited.month}/${note.lastEdited.year} às ${note.createdAt.hour}h${note.createdAt.minute}min',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormFieldTemplate(
                        maxLines: 10,
                        placeholderText: 'Escreva aqui...',
                        initialValue: note.content,
                        onSaved: (String? text) {
                          controller.note.content = text!;
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
              onPressed: () => controller.submit(context),
            ),
          ],
        ),
      ),
    );
  }
}
