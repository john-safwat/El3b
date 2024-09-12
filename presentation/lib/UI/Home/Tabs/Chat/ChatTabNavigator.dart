import 'package:core/Base/BaseNavigator.dart';
import 'package:domain/Models/Room/Room.dart';

abstract class ChatTabNavigator extends BaseNavigator {

  goToCreateRoomScreen();
  goToJoinRoomView(Room room);
  goToChatRoomScreen(Room room);

}