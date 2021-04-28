// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  Note({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.editedAt,
    this.image,
  });

  String id;
  String title;
  String description;
  int createdAt;
  int editedAt;
  String image;

  Note copyWith({
    String id,
    String title,
    String description,
    int createdAt,
    int editedAt,
    String image,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        editedAt: editedAt ?? this.editedAt,
        image: image ?? this.image,
      );

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        editedAt: json["edited_at"] == null ? null : json["edited_at"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt,
        "edited_at": editedAt == null ? null : editedAt,
        "image": image == null ? null : image,
      };
}
