// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    required this.id,
    required this.kitapadi,
    required this.kitapyazar,
    required this.sayfasayisi,
    required this.ciltno,
    required this.kitapyayinevi,
    required this.kitapturu,
    required this.v,
  });

  String id;
  String kitapadi;
  String kitapyazar;
  String sayfasayisi;
  String ciltno;
  String kitapyayinevi;
  String kitapturu;
  int v;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["_id"],
        kitapadi: json["kitapadi"],
        kitapyayinevi: json["kitapyayinevi"],
        kitapturu: json["kitapturu"],
        sayfasayisi: json["sayfasayisi"],
        ciltno: json["ciltno"],
        kitapyazar: json["kitapyazar"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "kitapadi": kitapadi,
        "kitapyayinevi": kitapyayinevi,
        "sayfasayisi": sayfasayisi,
        "ciltno": ciltno,
        "kitapyazar": kitapyazar,
        "kitapturu": kitapturu,
        "__v": v,
      };
}
