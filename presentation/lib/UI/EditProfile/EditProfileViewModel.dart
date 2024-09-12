
import 'package:core/Base/BaseViewModel.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:domain/UseCase/LoadUserDataUseCase.dart';
import 'package:domain/UseCase/UpdateUserProfileUseCase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presentation/UI/EditProfile/EditProfileNavigator.dart';

class EditProfileViewModel extends BaseViewModel<EditProfileNavigator> {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  DateTime birthDate = DateTime.now();
  late String selectedDate;

  LoadUserDataUseCase loadUserDataUseCase;
  UpdateUserProfileUseCase updateUserProfileUseCase;
  EditProfileViewModel({required this.loadUserDataUseCase ,required this.updateUserProfileUseCase});

  MyUser? user;
  String? errorMessage;

  // function to load user data
  void loadData()async{
    errorMessage = null;
    user = null;
    notifyListeners();
    try{
      user = await loadUserDataUseCase.invoke(uid: appConfigProvider!.getUser()!.uid);
      user ??= MyUser(
            name: appConfigProvider!.getUser()!.displayName??"No Name",
            email: appConfigProvider!.getUser()!.email??"No Email",
            password: "Private",
            image: appConfigProvider!.getUser()!.photoURL??"No Photo",
            phoneNumber: "",
            bio: local!.defaultBio,
            birthDate: local!.birthDate
        );
      nameController.text = user!.name;
      phoneController.text = user!.phoneNumber;
      bioController.text = user!.bio;
      selectedDate = user!.birthDate;
      notifyListeners();
    }catch(e){
      errorMessage = handleExceptions(e as Exception);
      notifyListeners();
    }
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

  // change Date function
  changeDate(DateTime? dateTime){
    if(dateTime != null){
      birthDate = dateTime;
      selectedDate = DateFormat("yMMMMd").format(dateTime);
      notifyListeners();
    }
  }

  // function to validate on user bio
  String? bioValidation(String value) {
    if(value.isEmpty){
      return local!.invalidBio;
    }
    return null;
  }

  // navigation functions
  // showDatePicker
  showDatePicker(){
    navigator!.showCustomDatePicker();
  }


  // function to update user data
  updateUserData()async{
    navigator!.showLoading(message: local!.loading);
    try{
      user!.name = nameController.text;
      user!.bio = bioController.text;
      user!.birthDate = selectedDate;
      user!.phoneNumber = phoneController.text;

      var response = await updateUserProfileUseCase.invoke(user: user!, uid: appConfigProvider!.getUser()!.uid , file: image);
      appConfigProvider!.updateUser(user: response);
      navigator!.goBack();
      navigator!.showSuccessMessage(message: local!.accountUpdated , posActionTitle: local!.ok );
    }catch(e){
      navigator!.goBack();
      navigator!.showFailMessage(message: handleExceptions(e as Exception), negativeActionTitle: local!.tryAgain);
    }
  }


}