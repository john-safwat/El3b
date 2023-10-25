import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Core/Extension/DateOnlyExtinsion.dart';
import 'package:El3b/Domain/Exception/FirebaseImagesException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/UseCase/AddRoomUseCase.dart';
import 'package:El3b/Presentation/Models/RoomType.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomNavigator.dart';
import 'package:flutter/material.dart';

class CreateRoomViewModel extends BaseViewModel<CreateRoomNavigator> {

  AddRoomUseCase addRoomUseCase ;
  CreateRoomViewModel({required this.addRoomUseCase});


  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  // list of rooms type
  List<RoomType> types = RoomType.getTypesList();
  // the initial type
  late RoomType selectedType ;
  // function to change the room type
  void changeSelectedType(RoomType newType){
    selectedType = newType;
    notifyListeners();
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

  // function to validate on user bio
  String? descriptionValidation(String value) {
    if(value.isEmpty){
      return local!.invalidBio;
    }
    return null;
  }

  // function to create room
  createRoom()async{
    if(formKey.currentState!.validate()){
      navigator!.showLoading(message: local!.loading);
      try{
        var response = await addRoomUseCase.invoke(
            "",
            nameController.text,
            descriptionController.text,
            image,
            selectedType.title,
            appConfigProvider!.user!.uid,
            DateTime.now().millisecondsSinceEpoch,
            appConfigProvider!.user!,
            appConfigProvider!.user!.uid
        );
        navigator!.goBack();
        navigator!.showSuccessMessage(message: local!.roomCreatedSuccessfully , posActionTitle:local!.ok , posAction: goBack );
      }catch(e){
        navigator!.goBack();
        if (e is FirebaseImagesException) {
          navigator!.showFailMessage(
            message: e.errorMessage,
            posActionTitle: local!.tryAgain,
          );
        } else if (e is FirebaseUserAuthException) {
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
        }else if (e is FirebaseUserDatabaseException) {
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

  // goToRoomsScreen
  goBack(){
    navigator!.goBack();
  }

}