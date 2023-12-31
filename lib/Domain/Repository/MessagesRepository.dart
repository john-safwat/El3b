import 'package:El3b/Data/Models/Messages/MessageDTO.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

abstract class MessagesRepository {

  Future<Message> sendMessage({required Message message , XFile? image});
  Stream<QuerySnapshot<MessageDTO>> readMessages({required String roomId});

}