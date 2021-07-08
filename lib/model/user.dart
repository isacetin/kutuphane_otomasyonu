// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.aldigikitaplar,
    required this.id,
    required this.tcno,
    required this.adsoyad,
    required this.telefon,
    required this.eposta,
    required this.adres,
    required this.v,
  });

  List<String> aldigikitaplar;
  String id;
  String tcno;
  String adsoyad;
  String telefon;
  String eposta;
  String adres;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    aldigikitaplar: List<String>.from(json["aldigikitaplar"].map((x) => x)),
    id: json["_id"],
    tcno: json["tcno"],
    adsoyad: json["adsoyad"],
    telefon: json["telefon"],
    eposta: json["eposta"],
    adres: json["adres"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "aldigikitaplar": List<dynamic>.from(aldigikitaplar.map((x) => x)),
    "_id": id,
    "tcno": tcno,
    "adsoyad": adsoyad,
    "telefon": telefon,
    "eposta": eposta,
    "adres": adres,
    "__v": v,
  };
}
