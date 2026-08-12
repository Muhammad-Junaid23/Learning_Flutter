
import 'package:backend_api/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;


  // set user
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  //get user
  UserModel? getUser ()=> _userModel;

}