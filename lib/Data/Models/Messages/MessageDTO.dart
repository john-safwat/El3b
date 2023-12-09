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
  bool receivedStatus;
  bool sendingStatus;
  bool readStatus;
  bool sendingError;
  int dateTime;
  bool sentState;
  MessageDTO(
      {required this.roomId,
      required this.messageId,
      required this.content,
      required this.type,
      required this.senderId,
      required this.senderName,
      required this.senderImage,
      required this.image,
      required this.receivedStatus,
      required this.sendingStatus,
      required this.readStatus,
      required this.dateTime,
      required this.sentState,
      required this.sendingError});

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
            receivedStatus: json['receivedStatus'],
            sendingStatus: json['sendingStatus'],
            readStatus: json['readStatus'],
            dateTime: json['time'],
            sentState: json['sentState'],
            sendingError: json["sendingError"]);

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
      "receivedStatus": receivedStatus,
      "sendingStatus": sendingStatus,
      "readStatus": readStatus,
      "time": dateTime,
      'sentState': sentState,
      "sendingError": sendingError
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
        receivedStatus: receivedStatus,
        sendingStatus: sendingStatus,
        readStatus: readStatus,
        dateTime: dateTime,
        sentState: sentState,
        sendingError: sendingError);
  }
}
