import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_automation/model/book.dart';
import 'package:library_automation/model/user.dart';

class DataServices {
  static const baseUrl = "http://192.168.1.36:3000/api";

  // --------------------  BOOK --------------------------

  Future<List<Book>?> getBook() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/books'));
      return (jsonDecode(response.body) as List).map((e) => Book.fromJson(e)).toList();
    } catch (e) {
      debugPrint("getBook Error : $e");
      return null;
    }
  }

  Future<bool> setBook(kitapadi, kitapyazar, kitapturu, sayfasayisi, ciltno, yayinevi) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/books'), body: {
        "kitapadi": kitapadi,
        "kitapyazar": kitapyazar,
        "kitapyayinevi": yayinevi,
        "kitapturu": kitapturu,
        "sayfasayisi": sayfasayisi,
        "ciltno": ciltno
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("setBook Error : $e");
      return false;
    }
  }

  Future<bool> updateBook(Book book) async {
    try {
      final response = await http.patch(Uri.parse('$baseUrl/books/${book.id}'), body: {
        "kitapadi": book.kitapadi,
        "kitapyazar": book.kitapyazar,
        "kitapyayinevi": book.kitapyayinevi,
        "kitapturu": book.kitapturu,
        "sayfasayisi": book.sayfasayisi,
        "ciltno": book.ciltno,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("updataBook Error : $e");
      return false;
    }
  }

  Future<bool> deleteBook(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/books/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("deleteBook Error : $e");
      return false;
    }
  }

  // --------------------  USER --------------------------

  Future<List<User>?> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      return (jsonDecode(response.body) as List).map((e) => User.fromJson(e)).toList();
    } catch (e) {
      debugPrint("getUsers Error : $e");
      return null;
    }
  }

  Future<bool> setUser(_tcno, _adsoyad, _telefon, _eposta, _adres) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/users'), body: {
        "tcno": _tcno,
        "adsoyad": _adsoyad,
        "telefon": _telefon,
        "eposta": _eposta,
        "adres": _adres,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("setBook Error : $e");
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      final response = await http.patch(Uri.parse('$baseUrl/users/${user.id}'), body: {
        "tcno": user.tcno,
        "adsoyad": user.adsoyad,
        "telefon": user.telefon,
        "eposta": user.eposta,
        "adres": user.adres,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("updataBook Error : $e");
      return false;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("deleteUser Error : $e");
      return false;
    }
  }

  Future<User?> searchUser(String tc) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$tc'));
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("searchUser Error : $e");
      return null;
    }
  }

// --------------------  EMANET --------------------------

  emanetAl(String tc, String kitapadi) async {
    try {
      final response = await http.patch(Uri.parse('$baseUrl/users/$tc/al/$kitapadi'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Emanet Al Error : $e");
      return false;
    }
  }

  emanetVer(String tc, String kitapadi) async {
    try {
      final response = await http.patch(Uri.parse('$baseUrl/users/$tc/ver/$kitapadi'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Emanet Ver Error : $e");
      return false;
    }
  }
}
