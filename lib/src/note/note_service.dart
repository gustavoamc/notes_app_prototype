import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes_app_prototype/api.dart';
import 'package:notes_app_prototype/src/note/note_model.dart';

class NoteService {
  static const String url = '/api/Note/';
  static const Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static Future<List<NoteModel>?> getNotes() async {
    var response = await http.get(
      Uri.http(Api.baseUrl(), url),
      headers: header,
    );

    if (Api.isSuccessful(response.statusCode)) {
      var data = jsonDecode(response.body);

      return List<NoteModel>.from(data.map((x) => NoteModel.fromJson(x)));
    }

    return null;
  }

  static Future<NoteModel> getNote(int id) async {
    var response = await http.get(
      Uri.http(Api.baseUrl(), '$url$id'),
      headers: header,
    );

    if (Api.isSuccessful(response.statusCode)) {
      return NoteModel.fromJson(jsonDecode(response.body));
    }

    return NoteModel();
  }

  static Future<bool> addNote(NoteModel note) async {
    var response = await http.post(
      Uri.http(Api.baseUrl(), url),
      headers: header,
      body: note.toJson(),
    );

    if (Api.isSuccessful(response.statusCode)) {
      return true;
    }

    return false;
  }

  static Future<bool> updateNote(NoteModel note) async {
    var response = await http.put(
      Uri.http(Api.baseUrl(), url),
      headers: header,
      body: note.toJson(),
    );

    if (Api.isSuccessful(response.statusCode)) {
      return true;
    }

    return false;
  }

  static Future<bool> removeNote(int id) async {
    var response = await http.delete(
      Uri.http(Api.baseUrl(), '$url$id'),
      headers: header,
    );

    if (Api.isSuccessful(response.statusCode)) {
      return true;
    }

    return false;
  }
}
