import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Data/Models/Room/RoomDTO.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/UseCase/GetGeneralRoomsUseCase.dart';
import 'package:El3b/Domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabNavigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatTabViewModel extends BaseViewModel <ChatTabNavigator>{

  GetUserRoomsUseCase getUserRoomsUseCase;
  GetGeneralRoomsUseCase getGeneralRoomsUseCase;
  ChatTabViewModel({required this.getUserRoomsUseCase , required this.getGeneralRoomsUseCase});

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

  // function to load data
  Stream<QuerySnapshot<RoomDTO>>getPublicRooms(){
    return getGeneralRoomsUseCase.invoke();
  }

  // function to remove user joined room from list
  void filterRooms(){
    for(int i =0 ; i< rooms.length ; i++) {
      if (rooms[i].users.contains(appConfigProvider!.user!.uid)) {
        rooms.removeWhere((element) => element.id == rooms[i].id);
        i--;
      }
    }
  }

}