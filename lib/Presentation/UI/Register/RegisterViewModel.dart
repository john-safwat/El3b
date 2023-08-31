import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Presentation/UI/Register/RegisterNavigator.dart';
import 'package:flutter/cupertino.dart';


class RegisterViewModel extends BaseViewModel<RegisterNavigator>{
  TextEditingController nameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController PasswordConfirmationController = TextEditingController();


  // validate on the name if it is not empty and doesn't contain ant spacial characters
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
  String? nameValidation (String input){
    if(input != null){

    }else{
      return "This Field Is Necessary";
    }
  }

  String? passwordConfirm (String input)
  {
    if(PasswordConfirmationController == PasswordController){

    }else{
      local!.passwordDoesntMatch;
    }
  }
}