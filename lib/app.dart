import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app_prototype/src/note/note_model.dart';
import 'package:notes_app_prototype/src/note/note_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel>? noteTest = [
    NoteModel(
        id: 0,
        createdAt: DateTime.now(),
        lastEdited: DateTime.now(),
        content: '')
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('Teste de notas'), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(noteTest!.first.id.toString()),
            const SizedBox(height: 5),
            Text(noteTest!.first.createdAt.toString()),
            const SizedBox(height: 5),
            Text(noteTest!.first.lastEdited.toString()),
            const SizedBox(height: 5),
            Text(noteTest!.first.content!),
            const SizedBox(height: 5),
            ElevatedButton(
              child: const Text("Atualizar"),
              onPressed: () async {
                // var response = await http.get(
                //   Uri.http(
                //     'localhost:5055',
                //     '/api/Note/1',
                //   ),
                //   headers: <String, String>{
                //     'Content-Type': 'application/json; charset=UTF-8',
                //   },
                // );
                // var data =
                //     json.decode(utf8.decode(response.bodyBytes)); //TODO bugged
                // noteTest = List<NoteModel>.from(
                //   data.map((x) => NoteModel.fromJson(x)),
                // );
                noteTest = await NoteService.getNotes();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    ));
  }
}
