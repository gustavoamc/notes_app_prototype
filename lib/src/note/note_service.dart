import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes_app_prototype/api.dart';
import 'package:notes_app_prototype/src/note/note_model.dart';

class NoteService {
  static const String url = '/api/Note';
  static Future<List<NoteModel>?> getNotes() async {
    var response = await http.get(Uri.http(Api.baseUrl(), url));

    if (Api.isSuccessful(response.statusCode)) {
      var data = json.decode(response.body);

      return List<NoteModel>.from(data.map((x) => NoteModel.fromJson(x)));
    }

    return null;
  }

  static Future<NoteModel> getNote(int id) async {
    var response = await http.get(
      Uri.http(Api.baseUrl(), '$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (Api.isSuccessful(response.statusCode)) {
      return NoteModel.fromJson(jsonDecode(response.body));
    }

    return NoteModel(); //TODO this is wrong
  }
}
