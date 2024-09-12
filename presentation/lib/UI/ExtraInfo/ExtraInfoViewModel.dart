
import 'package:core/Base/BaseViewModel.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:domain/UseCase/UpdateUserDataUseCase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';

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
    navigator!.goToLoginScreen();
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
              message: local!.weSentEmailVerification,
              posActionTitle: local!.ok,
              posAction: goToHomeScreen);
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

}