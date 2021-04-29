// To parse this JSON data, do
//
//     final dbUser = dbUserFromJson(jsonString);

import 'dart:convert';

DbUser dbUserFromJson(String str) => DbUser.fromJson(json.decode(str));

String dbUserToJson(DbUser data) => json.encode(data.toJson());

class DbUser {
  DbUser({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
  });

  String id;
  String name;
  String email;
  String photoUrl;

  DbUser copyWith({
    String id,
    String name,
    String email,
    String photoUrl,
  }) =>
      DbUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory DbUser.fromJson(Map<String, dynamic> json) => DbUser(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "photoUrl": photoUrl == null ? null : photoUrl,
      };
}
