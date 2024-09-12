import 'package:data/Models/Messages/MessageDTO.dart';
import 'package:domain/Models/Messages/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessagesRemoteDataSource {

  Future<Message> sendMessage({required MessageDTO message});
  Stream<QuerySnapshot<MessageDTO>> readMessages({required String roomId});

}