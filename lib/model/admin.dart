// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Admin userFromJson(String str) => Admin.fromJson(json.decode(str));

String userToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    required this.id,
    required this.password,
    required this.createdAt,
    required this.username,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String username;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["_id"],
    username: json["username"],
    password: json["password"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "password": password,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}