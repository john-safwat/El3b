import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {

  User? user;

  void updateUser({required User user}){
    this.user = user;
    notifyListeners();
  }

}