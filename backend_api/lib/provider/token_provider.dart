

import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  //set token
  void setToken(String val){
    _token = val;
    notifyListeners();
  }

  //get token
  String? getToken() => _token;

}