import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';

abstract class ChatTabNavigator extends BaseNavigator {

  goToCreateRoomScreen();
  goToJoinRoomView(Room room);

}