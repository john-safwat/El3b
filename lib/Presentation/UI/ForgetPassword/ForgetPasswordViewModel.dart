import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/UseCase/ResetPasswordUseCase.dart';
import 'package:El3b/Presentation/UI/ForgetPassword/ForgetPasswordNavigator.dart';
import 'package:flutter/material.dart';

class ForgetPasswordViewModel extends BaseViewModel<ForgetPasswordNavigator>{

  ResetPasswordUseCase useCase;
  ForgetPasswordViewModel({required this.useCase});

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();


  // navigation functions
  // function to go back to home screen
  goToLoginScreen(){
    navigator!.goBack();
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

  // send reset password function
  Future<void> resetPassword()async{
    if(formKey.currentState!.validate()){
      navigator!.showLoading(message: local!.sendingEmail);
      try {
        await useCase.invoke(email: emailController.text);
        navigator!.goBack();
        navigator!.showSuccessMessage(
          message: local!.emailSentSuccessfully,
          posAction: goToLoginScreen,
          posActionTitle: local!.ok
        );
      }catch (e){
        navigator!.goBack();
        if(e is TimeOutOperationsException){
          navigator!.showFailMessage(message: e.errorMessage, negativeActionTitle: local!.tryAgain);
        }else if (e is FirebaseUserAuthException){
          navigator!.showFailMessage(message: e.errorMessage, negativeActionTitle: local!.tryAgain);
        }else if (e is UnknownException){
          navigator!.showFailMessage(message: e.errorMessage, negativeActionTitle: local!.tryAgain);
        }else {
          navigator!.showFailMessage(message: e.toString(), negativeActionTitle: local!.tryAgain);
        }
      }
    }

  }



}