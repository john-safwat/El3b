import 'package:data/Models/Messages/message_dto.dart';
import 'package:domain/Models/Messages/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

abstract class MessagesRepository {

  Future<Message> sendMessage({required Message message , XFile? image});
  Stream<QuerySnapshot<MessageDTO>> readMessages({required String roomId});

}