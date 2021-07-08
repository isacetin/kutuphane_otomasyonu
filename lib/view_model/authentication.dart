import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_automation/model/admin.dart';
import 'package:http/http.dart' as http;

class Authentication {
  static const baseUrl = "http://192.168.1.36:3000/api";
  Admin? _user;

  Future<bool> login({required String username, required String password}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/admins/$username'));
      if (response.statusCode == 200) {
        _user = Admin.fromJson(jsonDecode(response.body));
        if (_user!.password == password) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
