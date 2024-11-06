
import 'package:core/Base/base_view_model.dart';
import 'package:domain/UseCase/add_room_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/Models/room_type.dart';
class CreateRoomViewModel extends BaseViewModel {

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
        navigator!.showFailMessage(
          message: handleExceptions(e as Exception),
          posActionTitle: local!.tryAgain,
        );
      }
    }
  }

  // goToRoomsScreen
  goBack(){
    navigator!.goBack();
  }

}