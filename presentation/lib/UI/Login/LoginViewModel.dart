import 'package:core/Base/base_view_model.dart';
import 'package:domain/Exception/firebase_user_database_exception.dart';
import 'package:domain/Models/User/my_user.dart';
import 'package:domain/UseCase/add_user_use_case.dart';
import 'package:domain/UseCase/check_if_user_exist_use_case.dart';
import 'package:domain/UseCase/sign_in_user_with_email_and_password_use_case.dart';
import 'package:domain/UseCase/sign_in_with_facebook_use_case.dart';
import 'package:domain/UseCase/sign_in_with_google_use_case.dart';
import 'package:presentation/UI/Login/LoginNavigator.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{

  SignInUserWithEmailAndPasswordUseCase singInUserWithEmailAndPasswordUseCase;
  CheckIfUserExistUseCase checkIfUserExistUseCase;
  AddUserUseCase addUserUseCase;
  SignInWithGoogleUseCase signInWithGoogleUseCase;
  SignInWithFacebookUseCase signInWithFacebookUseCase;
  LoginViewModel({
    required this.singInUserWithEmailAndPasswordUseCase ,
    required this.checkIfUserExistUseCase,
    required this.addUserUseCase,
    required this.signInWithGoogleUseCase ,
    required this.signInWithFacebookUseCase
  });
  
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool googleLogin = false ;
  bool facebookLogin = false ;

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
  // go to Extra infoScreen function
  void goToExtraInfoScreen(){
    navigator!.goToExtraInfoScreen();
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
        var exist = await checkIfUserExistUseCase.invoke(uid: response.uid);
        appConfigProvider!.updateUser(user: response);
        if(exist) {
          navigator!.goBack();
          if(response.emailVerified){
            navigator!.showSuccessMessage(
                message: local!.welcomeBack,
                posActionTitle: local!.ok,
                posAction: goToHomeScreen
            );
          }else {
            navigator!.showFailMessage(
                message: local!.emailNotVerified,
                posActionTitle: local!.resend,
                posAction: sendVerificationMail,
                negativeActionTitle: local!.cancel
            );
          }
        }else {
          try{
            // add user data to database
            await addUserUseCase.invoke(uid: response.uid,
                myUser: MyUser(
                    name: response.displayName!,
                    email: response.email!,
                    password: "Private",
                    image: response.photoURL??"",
                    phoneNumber: "",
                    bio: local!.defaultBio,
                    birthDate: "--/--/----"
                )
            );
            navigator!.goBack();
            if(response.emailVerified){
              navigator!.showSuccessMessage(
                  message: local!.welcomeBack,
                  posActionTitle: local!.ok,
                  posAction: goToHomeScreen
              );
            }else {
              navigator!.showFailMessage(
                  message: local!.weSentEmailVerification,
                  posActionTitle: local!.ok,
                  posAction: (){}
              );
            }
          }catch(e){
            throw FirebaseFireStoreDatabaseException(errorMessage: local!.tryAgain);
          }
        }
      }catch(e){
        navigator!.goBack();
        navigator!.showFailMessage(
          message: handleExceptions(e as Exception),
          posActionTitle: local!.tryAgain,
        );
      }
    }
  }


  // login with google
  // in this function login with google if user doesn't exist it will create a new user in firebase auth
  void loginWithGoogle()async{
    googleLogin = true ;
    notifyListeners();
    try{
      // sing user in using google sign in
      var response = await signInWithGoogleUseCase.invoke();
      // update Provider
      appConfigProvider!.updateUser(user: response);
      try{
        // check if user exist in data base to make sure that we have the user info
        var exist = await checkIfUserExistUseCase.invoke(uid: response.uid);
        // if exist navigate to home screen else add user data to database
        if(exist) {
          navigator!.showSuccessMessage(
              message: local!.welcomeBack,
              posActionTitle: local!.ok,
              posAction: goToHomeScreen
          );
        }else {
          try{
            // add user data to database
            await addUserUseCase.invoke(uid: response.uid,
                myUser: MyUser(
                  name: response.displayName!,
                  email: response.email!,
                  password: "Private",
                  image: response.photoURL??"",
                  phoneNumber: "",
                  bio: local!.defaultBio,
                  birthDate: "--/--/----"
                )
            );
            navigator!.showSuccessMessage(
                message: local!.welcomeBack,
                posActionTitle: local!.ok,
                posAction: goToExtraInfoScreen
            );
          }catch(e){
            throw FirebaseFireStoreDatabaseException(errorMessage: local!.tryAgain);
          }
        }
      }catch(e){
        throw FirebaseFireStoreDatabaseException(errorMessage: local!.tryAgain);
      }
    }catch(e){
      googleLogin = false;
      notifyListeners();
      navigator!.showFailMessage(
        message: handleExceptions(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }
  }

  // // login with facebook
  // // in this function login with facebook if user doesn't exist it will create a new user in firebase auth
  // void loginWithFacebook()async{
  //   navigator!.showLoading(message: local!.loggingYouIn);
  //   try{
  //     // sing user in using facebook sign in
  //     var response = await signInWithFacebookUseCase.invoke();
  //     // update Provider
  //     appConfigProvider!.updateUser(user: response);
  //     try{
  //       // check if user exist in data base to make sure that we have the user info
  //       var exist = await checkIfUserExistUseCase.invoke(uid: response.uid);
  //       // if exist navigate to home screen else add user data to database
  //       if(exist) {
  //         navigator!.goBack();
  //         navigator!.showSuccessMessage(
  //             message: local!.welcomeBack,
  //             posActionTitle: local!.ok,
  //             posAction: goToHomeScreen
  //         );
  //       }else {
  //         try{
  //           // add user data to database
  //           await addUserUseCase.invoke(uid: response.uid,
  //               myUser: MyUser(
  //                   name: response.displayName!,
  //                   email: response.email!,
  //                   password: "Private",
  //                   image: response.photoURL??"",
  //                   phoneNumber: "",
  //                   bio: local!.defaultBio,
  //                   birthDate: "--/--/----"
  //               )
  //           );
  //           navigator!.goBack();
  //           navigator!.showSuccessMessage(
  //               message: local!.welcomeBack,
  //               posActionTitle: local!.ok,
  //               posAction: goToExtraInfoScreen
  //           );
  //         }catch(e){
  //           throw FirebaseFireStoreDatabaseException(errorMessage: local!.tryAgain);
  //         }
  //       }
  //     }catch(e){
  //       throw FirebaseFireStoreDatabaseException(errorMessage: local!.tryAgain);
  //     }
  //   }catch(e){
  //     navigator!.goBack();
  //     navigator!.showFailMessage(
  //       message: handleExceptions(e as Exception),
  //       posActionTitle: local!.tryAgain,
  //     );
  //   }
  // }

  Future<void> sendVerificationMail()async{
    navigator!.goBack();
    try{
      navigator!.showLoading(message: local!.loading);
      await appConfigProvider!.getUser()!.sendEmailVerification();
      navigator!.goBack();
      navigator!.showSuccessMessage(message: local!.weSentEmailVerification , posActionTitle: local!.ok);
    }
    catch (e){
      navigator!.goBack();
      navigator!.showFailMessage(message: local!.someThingWentWrong,posActionTitle: local!.tryAgain);
    }

  }

}