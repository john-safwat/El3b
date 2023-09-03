import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/UseCase/SignInUserWithEmailAndPasswordUseCase.dart';
import 'package:El3b/Presentation/UI/Login/LoginNavigator.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{

  SignInUserWithEmailAndPasswordUseCase singInUserWithEmailAndPasswordUseCase;
  LoginViewModel({required this.singInUserWithEmailAndPasswordUseCase});
  
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // navigation Functions
  // function to navigate to registration screen
  void goToRegistrationScreen(){
    navigator!.goToRegistrationScreen();
  }
  // go to home screen function
  void goToHomeScreen(){
    navigator!.goToHomeScreen();
  }
  // go to forget password screen
  void goToForgetPasswordScreen(){
    navigator!.goToForgetPasswordScreen();
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
  
  // login with email and password to firebase 
  Future<void> signInWithEmailAndPassword()async{
    if(formKey.currentState!.validate()){
      navigator!.showLoading(message: local!.loggingYouIn);
      try{
        var response = await singInUserWithEmailAndPasswordUseCase.invoke(
            email: emailController.text,
            password: passwordController.text
        );
        appConfigProvider!.updateUser(user: response);
        navigator!.goBack();
        navigator!.showSuccessMessage(
          message: local!.welcomeBack,
          posActionTitle: local!.ok,
          posAction: goToHomeScreen
        );
      }catch(e){
        navigator!.goBack();
        if (e is FirebaseUserAuthException) {
          navigator!.showFailMessage(
            message: e.errorMessage,
            posActionTitle: local!.tryAgain,
          );
        } else if (e is TimeOutOperationsException) {
          navigator!.showFailMessage(
            message: e.errorMessage,
            posActionTitle: local!.tryAgain,
          );
        } else if (e is UnknownException) {
          navigator!.showFailMessage(
            message: e.errorMessage,
            posActionTitle: local!.tryAgain,
          );
        } else {
          navigator!.showFailMessage(
            message: e.toString(),
            posActionTitle: local!.tryAgain,
          );
        }
      }
    }
  }

  // login with google
  void loginWithGoogle(){}

  // login with facebook
  void loginWithFacebook(){}

}
