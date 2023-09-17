import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/UseCase/UpdateUserDataUseCase.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExtraInfoViewModel extends BaseViewModel<ExtraInfoNavigator> {

  UpdateUserDataUseCase useCase;
  ExtraInfoViewModel({required this.useCase});

  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  late TextEditingController bioController = TextEditingController(text: local!.defaultBio);

  DateTime birthDate = DateTime.now();
  late String selectedDate = local!.birthDate;


  // navigation functions
  // showDatePicker
  showDatePicker(){
    navigator!.showCustomDatePicker();
  }
  // go to Home Screen
  goToHomeScreen(){
    navigator!.goToHomeScreen();
  }


  // validation function
  // mobile validation function to check for the phone number
  String? phoneValidation(String value) {
    if (value.isEmpty) {
      return local!.enterPhoneNumber;
    }
    else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return local!.enterValidMobileNumber;
    }
    return null;
  }

  // function to validate on user bio
  String? bioValidation(String value) {
    if(value.isEmpty){
      return local!.invalidBio;
    }
    return null;
  }

  // change Date function
  changeDate(DateTime? dateTime){
    if(dateTime != null){
      birthDate = dateTime;
      selectedDate = DateFormat("yMMMMd").format(dateTime);
      notifyListeners();
    }
  }


  // function to update user data in database
  Future<void> updateUserData() async{
    if(selectedDate == local!.birthDate){
      navigator!.showFailMessage(
        message: local!.pleasePickYourBirthDate,
        posActionTitle: local!.pickDate,
        posAction: showDatePicker
      );
    }else{
      if(formKey.currentState!.validate()){
        navigator!.showLoading(message: local!.updatingData);
        try {
          await useCase.invoke(
              uid: appConfigProvider!.getUser()!.uid,
              user: MyUser(
                  name: appConfigProvider!.getUser()!.displayName!,
                  email: appConfigProvider!.getUser()!.email!,
                  password: "Private",
                  image: appConfigProvider!.getUser()!.photoURL??"",
                  phoneNumber: phoneController.text,
                  bio: bioController.text,
                  birthDate: selectedDate)
          );
          navigator!.goBack();
          navigator!.showSuccessMessage(
              message: local!.accountUpdated,
              posActionTitle: local!.ok,
              posAction: goToHomeScreen);
        } catch (e) {
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
          } else if (e is FirebaseUserDatabaseException) {
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

  }

}