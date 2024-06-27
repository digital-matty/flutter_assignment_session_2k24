
import 'package:flutter/cupertino.dart';

import '../db/sql_helper.dart';
import '../model/user.dart';



class UserListProvider with ChangeNotifier {
  final db = UserDbProvider();

  Future<List<User>> getUserList() async {
    List<User> _userList = await db.fetchUsers();

    return _userList;
  }

  Future<void> addUser(User user) async {
    await db.addUser(user);

    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    await db.updateUser(user.id!, user);

    notifyListeners();
  }

  Future<void> deleteUser(int userId) async {
    await db.deleteUser(userId);

    notifyListeners();
  }
}
