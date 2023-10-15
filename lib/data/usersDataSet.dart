import 'package:flutter/material.dart';
import 'package:pizza_tz/models/user.dart';
import 'package:pizza_tz/data/roles.dart';

class UserList with ChangeNotifier {
  final List<User> _userList =  <User> [
    User(1, "Иван", Roles.defaultUser),
    User(2, "admin", Roles.adminUser)
  ];

  List<User> get getUsers => _userList;

  final List<int> _indexesUsersList = <int> [];

  set addUser(User user) {
    createIndexesPizzasList();

    if (_indexesUsersList.contains(user.idUser)) {
      user.idUser = _indexesUsersList.last + 1;
    }

    _userList.add(user);
    notifyListeners();
  }

  void createIndexesPizzasList() {
    _indexesUsersList.clear();
    for (User user in _userList) {
      _indexesUsersList.add(user.idUser);
    }
  }
}