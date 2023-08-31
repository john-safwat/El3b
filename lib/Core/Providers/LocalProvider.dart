import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {
  String currentLocal = "en";

  Future<void> changeLocal(String newLocal)async{

    if(newLocal == currentLocal) {return;}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLocal = newLocal;
    prefs.setString("local", currentLocal);
    notifyListeners();
  }

  bool isEn(){
    return currentLocal == "en";
  }

}