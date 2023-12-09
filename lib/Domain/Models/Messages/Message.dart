import 'package:El3b/Data/Models/Messages/MessageDTO.dart';

class Message{
  String roomId;
  String messageId;
  String content;
  String type;
  String senderName;
  String senderId;
  String senderImage;
  String image;
  int dateTime;
  Message({
    required this.roomId,
    required this.messageId ,
    required this.content ,
    required this.type,
    required this.senderId ,
    required this.senderName ,
    required this.senderImage ,
    required this.image ,
    required this.dateTime,
  });

  MessageDTO toDatasource(){
    return MessageDTO(
      roomId: roomId,
      messageId: messageId,
      content: content,
      type: type,
      senderName: senderImage,
      senderId: senderId,
      senderImage: senderImage,
      image: image,
      dateTime: dateTime,
    );
  }
}