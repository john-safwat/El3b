import 'package:core/Base/base_view_model.dart';
import 'package:domain/Models/User/my_user.dart';
import 'package:domain/UseCase/create_account_use_case.dart';
import 'package:presentation/UI/Register/RegisterNavigator.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  CreateAccountUseCase useCase;
  RegisterViewModel({required this.useCase});

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  // navigation Functions
  // function to navigate to registration screen
  void goToLoginScreen() {
    navigator!.goToLoginScreen();
  }

  // function to go to Extra info Screen()
  void goToExtraInfoScreen() {
    navigator!.goToExtraInfoScreen();
  }

  // validation functions
  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name) {
    if (name.isEmpty) {
      return local!.nameCantBeEmpty;
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)) {
      return local!.invalidName;
    } else {
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
  String? passwordConfirmationValidation(String input) {
    if (input.isEmpty) {
      return local!.passwordCantBeEmpty;
    } else if (input != passwordController.text) {
      return local!.passwordDoseNotMatch;
    }
    return null;
  }

  // create account function
  Future<void> createAccount() async {
    if (formKey.currentState!.validate()) {
      navigator!.showLoading(
        message: local!.creatingAccount,
      );
      try {
        var response = await useCase.invoke(
          file: image,
          user: MyUser(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
              image: "",
              phoneNumber: "",
              bio: local!.defaultBio,
              birthDate: "--/--/----")
        );
        appConfigProvider!.updateUser(user: response);
        if(!response.emailVerified){
          await response.sendEmailVerification();
        }
        navigator!.goBack();
        navigator!.showSuccessMessage(
            message: local!.accountCreatedSuccessfully,
            posActionTitle: local!.ok,
            posAction: goToExtraInfoScreen);
      } catch (e) {
        navigator!.goBack();
        navigator!.showFailMessage(
          message: handleExceptions(e as Exception),
          posActionTitle: local!.tryAgain,
        );
      }
    }
  }
}
