import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {
  String _currentLocal = "en";

  Future<void> changeLocal(String newLocal)async{

    if(newLocal == _currentLocal) {return;}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentLocal = newLocal;
    prefs.setString("local", _currentLocal);
    notifyListeners();
  }

  bool isEn(){
    return _currentLocal == "en";
  }

  String getLocal(){
    return _currentLocal;
  }

}