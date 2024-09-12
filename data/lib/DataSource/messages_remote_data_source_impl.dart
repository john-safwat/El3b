import 'dart:async';

import 'package:data/Firebase/firebase_messages_database.dart';
import 'package:data/Models/Messages/message_dto.dart';
import 'package:domain/DataSource/MessagesRemoteDataSource.dart';
import 'package:domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:domain/Models/Messages/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


MessagesRemoteDataSource injectMessagesRemoteDataSource(){
  return MessagesRemoteDataSourceImpl(database: injectFirebaseMessagesDatabase());
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {

  FirebaseMessagesDatabase database;
  MessagesRemoteDataSourceImpl({required this.database});

  @override
  Future<Message> sendMessage({required MessageDTO message}) async{
    try{
      var response = await database.sendMessages(message).timeout(const Duration(seconds: 60));
      return response.toDomain();
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException{
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Stream<QuerySnapshot<MessageDTO>> readMessages({required String roomId}) {
    return database.getMessagesStream(roomId: roomId);
  }
}