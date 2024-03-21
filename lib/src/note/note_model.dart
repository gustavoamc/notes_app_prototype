// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  int? id;
  DateTime createdAt;
  DateTime lastEdited;
  String content;

  NoteModel({
    this.id,
    createdAt, //why this works ? fuck it thats why
    lastEdited,
    this.content = '',
  })  : createdAt = createdAt ?? DateTime.now().toUtc(),
        lastEdited = lastEdited ?? DateTime.now().toUtc();

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]).toUtc(),
        lastEdited: DateTime.parse(json["lastEdited"]).toUtc(),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toUtc().toIso8601String(),
        "lastEdited": lastEdited.toUtc().toIso8601String(),
        "content": content,
      };
}
