import 'package:core/Base/base_view_model.dart';
import 'package:domain/UseCase/update_user_password_use_case.dart';
import 'package:flutter/material.dart';
class ResetPasswordViewModel extends BaseViewModel{

  UpdateUserPasswordUseCase useCase;
  ResetPasswordViewModel({required this.useCase});

  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController = TextEditingController();

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
  String? passwordConfirmationValidation(String input) {
    if (input.isEmpty) {
      return local!.passwordCantBeEmpty;
    } else if (input != newPasswordController.text) {
      return local!.passwordDoseNotMatch;
    }
    return null;
  }

  Future<void> updatePassword()async{
    if(formKey.currentState!.validate()){
      try{
        navigator!.showLoading(message: local!.loading);
        await useCase.invoke(
            email: appConfigProvider!.user!.email!,
            password: passwordController.text,
            newPassword: newPasswordController.text
        );
        passwordController.text = "";
        newPasswordController.text = "";
        newPasswordConfirmationController.text = "";
        navigator!.goBack();
        navigator!.showSuccessMessage(message: local!.passwordUpdated , posActionTitle: local!.ok);
      }catch(e){
        navigator!.goBack();
        navigator!.showFailMessage(message: handleExceptions(e as Exception) , posActionTitle: local!.tryAgain);
      }
    }
  }

}