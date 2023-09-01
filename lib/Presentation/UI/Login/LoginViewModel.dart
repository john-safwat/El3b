import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Presentation/UI/Login/LoginNavigator.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // navigation Functions
  // function to navigate to registration screen
  void goToRegistrationScreen(){
    navigator!.goToRegistrationScreen();
  }


  // Change Theme Functions
  void changeTheme(){
    themeProvider!.changeTheme(themeProvider!.isDark() ? ThemeMode.light : ThemeMode.dark);
  }

  // validation function
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

  // login with google
  void loginWithGoogle(){}

  // login with facebook
  void loginWithFacebook(){}

}
