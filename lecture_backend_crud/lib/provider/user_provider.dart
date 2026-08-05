import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  UserModel _userModel = UserModel();


  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  UserModel getUser() => _userModel;

}