import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Exception/FirebaseImagesException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:El3b/Presentation/UI/Register/RegisterNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  CreateAccountUseCase useCase;
  RegisterViewModel({required this.useCase});

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  XFile? image;

  // image picker from camera
  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  // image picker from gallery
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  // navigation Functions
  // function to navigate to registration screen
  void goToLoginScreen() {
    navigator!.goToLoginScreen();
  }

  // function to show modal Bottom Sheet
  void showMyModalBottomSheet() {
    navigator!.showMyModalBottomSheetWidget();
  }

  // function to go to Extra info Screen()
  void goToExtraInfoScreen(){
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
          message: "Creating Account...",
          backgroundColor:
              themeProvider!.isDark() ? MyTheme.purple : MyTheme.offWhite);
      try {
        var response = await useCase.invoke(
            image: image,
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text);
        appConfigProvider!.updateUser(user: response);
        navigator!.goBack();
        navigator!.showSuccessMessage(
            message: "Account Created Successfully",
            backgroundColor: themeProvider!.isDark() ? MyTheme.purple : MyTheme.offWhite,
            posActionTitle: "Ok",
            posAction: goToExtraInfoScreen
        );

      } catch (e) {
        navigator!.goBack();
        if (e is FirebaseImagesException) {
          navigator!.showFailMessage(
              message: e.errorMessage,
              posActionTitle: "Try Again",
              backgroundColor: themeProvider!.isDark() ? MyTheme.purple : MyTheme.offWhite);
        } else if (e is FirebaseUserAuthException) {
          navigator!.showFailMessage(
              message: e.errorMessage,
              posActionTitle: "Try Again",
              backgroundColor: themeProvider!.isDark() ? MyTheme.purple : MyTheme.offWhite);
        } else if (e is TimeOutOperationsException) {
          navigator!.showFailMessage(
              message: e.errorMessage,
              posActionTitle: "Try Again",
              backgroundColor: themeProvider!.isDark() ? MyTheme.purple : MyTheme.offWhite);
        } else if (e is UnknownException) {
          navigator!.showFailMessage(
              message: e.errorMessage,
              posActionTitle: "Try Again",
              backgroundColor: themeProvider!.isDark() ? MyTheme.purple : MyTheme.offWhite);
        } else {
          navigator!.showFailMessage(
              message: e.toString(),
              posActionTitle: "Try Again",
              backgroundColor: themeProvider!.isDark() ? MyTheme.purple : MyTheme.offWhite);
        }
      }
    }
  }
}
