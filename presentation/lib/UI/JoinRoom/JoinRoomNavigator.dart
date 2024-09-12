import 'package:core/Base/base_navigator.dart';
import 'package:domain/Models/Room/room.dart';

abstract class JoinRoomNavigator extends BaseNavigator {

  goToRoomChatScreen(Room room);

}