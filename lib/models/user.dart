import 'package:pizza_tz/data/roles.dart';

class User {
  int _idUser;
  String _nameUser;
  final Roles _roleUser;

  int get idUser => _idUser;
  set idUser(int value) => _idUser = value;

  String get nameUser => _nameUser;
  set nameUser(String value) => _nameUser = value;

  Roles get roleUser => _roleUser;

  User(this._idUser, this._nameUser, this._roleUser);
}