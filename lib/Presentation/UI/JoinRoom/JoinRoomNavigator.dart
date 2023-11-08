import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';

abstract class JoinRoomNavigator extends BaseNavigator {

  goToRoomChatScreen(Room room);

}