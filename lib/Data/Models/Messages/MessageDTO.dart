import 'package:El3b/Domain/Models/Messages/Message.dart';

class MessageDTO {
  String roomId;
  String messageId;
  String content;
  String type;
  String senderName;
  String senderId;
  String senderImage;
  String image;
  int dateTime;
  MessageDTO(
      {required this.roomId,
      required this.messageId,
      required this.content,
      required this.type,
      required this.senderId,
      required this.senderName,
      required this.senderImage,
      required this.image,
      required this.dateTime,});

  MessageDTO.fromFireStore(Map<String, dynamic> json)
      : this(
            roomId: json['roomId'],
            messageId: json['messageId'],
            content: json['content'],
            type: json['type'],
            senderName: json['senderName'],
            senderId: json['senderId'],
            senderImage: json['senderImage'],
            image: json['image'],
            dateTime: json['time'],);

  Map<String, dynamic> toFireStore() {
    return {
      "roomId": roomId,
      "messageId": messageId,
      "content": content,
      "type": type,
      "senderName": senderName,
      "senderId": senderId,
      "senderImage": senderImage,
      "image": image,
      "time": dateTime,
    };
  }

  Message toDomain() {
    return Message(
        roomId: roomId,
        messageId: messageId,
        content: content,
        type: type,
        senderId: senderId,
        senderName: senderName,
        senderImage: senderImage,
        image: image,
        dateTime: dateTime);
  }
}
