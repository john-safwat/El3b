import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {

  User? _user;

  void updateUser({required User user}){
    _user = user;
    notifyListeners();
  }

  void updateUserWithoutNotifyListeners({required User user}){
    _user = user;
  }

  User? getUser(){
    return _user!;
  }

}