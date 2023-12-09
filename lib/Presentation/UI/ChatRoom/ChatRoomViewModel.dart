import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/UseCase/SendMessageUseCase.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomNavigator.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomViewModel.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomViewModel extends BaseViewModel<ChatRoomNavigator>{

  SendMessageUseCase useCase;
  TextEditingController controller = TextEditingController();
  late Room room;

  ChatRoomViewModel({required this.useCase});

  sendMessage(){
    if (controller.text.isNotEmpty || image != null){
      try{
        var message = Message(
            roomId: room.id,
            messageId: "",
            content: controller.text,
            type: image != null ?"Image" : "Text",
            senderId: appConfigProvider!.user!.uid,
            senderName: appConfigProvider!.user!.displayName??"None",
            senderImage: appConfigProvider!.user!.photoURL??"None",
            image: "image",
            receivedStatus: false,
            sendingStatus: true,
            readStatus: false,
            dateTime: DateTime.now().millisecondsSinceEpoch,
            sentState: false,
            sendingError: false);
      }catch(e){
        navigator!.showErrorNotification(message: handleExceptions(e as Exception));
      }
    }
  }

}