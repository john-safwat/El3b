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
  bool receivedStatus;
  bool sendingStatus;
  bool readStatus;
  bool sendingError ;
  int dateTime;
  bool sentState;
  Message({
    required this.roomId,
    required this.messageId ,
    required this.content ,
    required this.type,
    required this.senderId ,
    required this.senderName ,
    required this.senderImage ,
    required this.image ,
    required this.receivedStatus ,
    required this.sendingStatus ,
    required this.readStatus ,
    required this.dateTime,
    required this.sentState,
    required this.sendingError
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
      receivedStatus: receivedStatus,
      sendingStatus: sendingStatus,
      readStatus: readStatus,
      dateTime: dateTime,
      sentState: sentState,
      sendingError: sendingError
    );
  }
}