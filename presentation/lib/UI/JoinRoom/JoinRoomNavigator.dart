import 'package:core/Base/BaseNavigator.dart';
import 'package:domain/Models/Room/Room.dart';

abstract class JoinRoomNavigator extends BaseNavigator {

  goToRoomChatScreen(Room room);

}