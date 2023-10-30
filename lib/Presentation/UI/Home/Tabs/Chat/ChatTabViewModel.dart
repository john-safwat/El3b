import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Data/Models/Room/RoomDTO.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabNavigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatTabViewModel extends BaseViewModel <ChatTabNavigator>{

  GetUserRoomsUseCase getUserRoomsUseCase;
  ChatTabViewModel({required this.getUserRoomsUseCase});

  String? errorMessage;

  List<Room> userRooms = [];
  List<Room> rooms = [];

  // function to go to create room screen
  goToCreateRoomScreen(){
    navigator!.goToCreateRoomScreen();
  }

  // function to load data
  Stream<QuerySnapshot<RoomDTO>>getUserRooms(){
    return getUserRoomsUseCase.invoke(appConfigProvider!.user!.uid);
  }


}