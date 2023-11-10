import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomNavigator.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomViewModel extends BaseViewModel<ChatRoomNavigator>{

  TextEditingController controller = TextEditingController();

  late Room room;



}