import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/Base/BaseViewModel.dart';
import 'package:data/Models/Messages/MessageDTO.dart';
import 'package:domain/Models/Messages/Message.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:domain/UseCase/GetMessagesUseCase.dart';
import 'package:domain/UseCase/SendMessageUseCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:presentation/UI/ChatRoom/ChatRoomNavigator.dart';

class ChatRoomViewModel extends BaseViewModel<ChatRoomNavigator>{

  SendMessageUseCase sendMessageUseCase;
  GetMessagesUseCase getMessagesUseCase;
  TextEditingController controller = TextEditingController();
  late Room room;

  ChatRoomViewModel({required this.sendMessageUseCase , required this.getMessagesUseCase});

  List<Message> messages = [];

  // read messages function
  Stream<QuerySnapshot<MessageDTO>> getMessages(){
    return getMessagesUseCase.invoke(roomId: room.id);
  }

  // function to send message
  sendMessage()async{
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
            dateTime: DateTime.now().millisecondsSinceEpoch,
        );
        var response = await sendMessageUseCase.invoke(message: message , image: image);
        controller.text = "";
      }catch(e){
        navigator!.showErrorNotification(message: handleExceptions(e as Exception));
      }
    }
  }

  onMoreInfoPress(){

  }

  onExitPress(){

  }

}