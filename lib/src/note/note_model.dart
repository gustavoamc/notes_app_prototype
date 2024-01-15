// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  int? id;
  DateTime? createdAt;
  DateTime? lastEdited;
  String? content;

  NoteModel({
    this.id,
    this.createdAt,
    this.lastEdited,
    this.content,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        lastEdited: DateTime.parse(json["lastEdited"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt!.toIso8601String(),
        "lastEdited": lastEdited!.toIso8601String(),
        "content": content,
      };
}
