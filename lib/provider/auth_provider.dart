import 'package:flutter/material.dart';

import '../db/dbhelper.dart';


class AuthProvider with ChangeNotifier {
  String? _username;

  String? get username => _username;

  Future<bool> login(String username, String password) async {
    final user = await DatabaseHelper.instance.getUser(username);
    if (user != null && user['password'] == password) {
      _username = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String password, String contactNumber, String email, String startDate, String submissionDate) async {
    final user = await DatabaseHelper.instance.getUser(username);
    if (user == null) {
      await DatabaseHelper.instance.createUser(username, password, contactNumber, email, startDate, submissionDate);
      _username = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _username = null;
    notifyListeners();
  }
}
