
import 'package:data/Models/Messages/message_dto.dart';
import 'package:data/Repository/messages_repository_impl.dart';
import 'package:domain/Repository/messages_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GetMessagesUseCase injectGetMessagesUseCase(){
  return GetMessagesUseCase(repository: injectMessagesRepository());
}

class GetMessagesUseCase {

  MessagesRepository repository;
  GetMessagesUseCase({required this.repository});

  Stream<QuerySnapshot<MessageDTO>> invoke({required String roomId}){
    return repository.readMessages(roomId: roomId);
  }


}