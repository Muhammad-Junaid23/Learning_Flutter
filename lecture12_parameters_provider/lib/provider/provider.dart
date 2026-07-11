import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  String _title = "";
  String _description = "";

  void setTitle(String value){
    _title = value;
    notifyListeners();
  }

  void setDescription(String value){
    _description = value;
    notifyListeners();
  }

  String getTitle()=> _title;
  String getDescription()=> _description;
}