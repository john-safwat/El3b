import 'package:core/Base/base_view_model.dart';
import 'package:data/Models/Room/room_dto.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:domain/UseCase/GetGeneralRoomsUseCase.dart';
import 'package:domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:presentation/UI/Home/Tabs/Chat/ChatTabNavigator.dart';
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

  goToJoinRoomScree(Room room){
    navigator!.goToJoinRoomView(room);
  }

  goToChatRoomScreen(Room room){
    navigator!.goToChatRoomScreen(room);
  }

}