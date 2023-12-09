import 'package:El3b/Data/Models/Messages/MessageDTO.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessagesRemoteDataSource {

  Future<Message> sendMessage({required MessageDTO message});
  Stream<QuerySnapshot<MessageDTO>> readMessages({required String roomId});

}