import 'package:core/Base/base_navigator.dart';
import 'package:domain/Models/Room/room.dart';

abstract class ChatTabNavigator extends BaseNavigator {

  goToCreateRoomScreen();
  goToJoinRoomView(Room room);
  goToChatRoomScreen(Room room);

}