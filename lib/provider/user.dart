import 'package:amir_backend/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel();

  void setUser(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  UserModel getUser() => _userModel;
}
