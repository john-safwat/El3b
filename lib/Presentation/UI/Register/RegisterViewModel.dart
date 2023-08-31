import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Presentation/UI/Register/RegisterNavigator.dart';
import 'package:flutter/material.dart';


class RegisterViewModel extends BaseViewModel<RegisterNavigator>{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();


  // navigation Functions
  // function to navigate to registration screen
  void goToLoginScreen(){
    navigator!.goToLoginScreen();
  }

  // function to show modal Bottom Sheet
  void showMyModalBottomSheet(){
    navigator!.showMyModalBottomSheetWidget();
  }

  // Change Theme Functions
  void changeTheme(){
    themeProvider!.changeTheme(themeProvider!.isDark() ? ThemeMode.light : ThemeMode.dark);
  }
  // Change Local Functions
  void changeLocal(){
    localProvider!.changeLocal(localProvider!.currentLocal == 'en' ? "ar" : 'en');
  }


  // validation functions
  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name){
    if (name.isEmpty){
      return local!.nameCantBeEmpty;
    }else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)){
      return local!.invalidName;
    }else {
      return null;
    }
  }

  // validate on the email form
  String? emailValidation(String input) {
    if (input.isEmpty) {
      return local!.emailCantBeEmpty;
    } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(input)) {
      return local!.enterAValidEmail;
    }
    return null;
  }

  // validate the password is not less than 8 chars
  String? passwordValidation(String input) {
    if (input.isEmpty) {
      return local!.passwordCantBeEmpty;
    } else if (input.length < 8) {
      return local!.invalidPasswordLength;
    }
    return null;
  }

  // validate the password confirmation is not empty and the same as the password
  String? passwordConfirmationValidation(String input){
    if (input.isEmpty) {
      return local!.passwordCantBeEmpty;
    } else if (input != passwordController.text) {
      return local!.passwordDoseNotMatch;
    }
    return null;
  }



}