
import 'package:El3b/Data/Models/Messages/MessageDTO.dart';
import 'package:El3b/Data/Repository/MessagesRepositoryImpl.dart';
import 'package:El3b/Domain/Repository/MessagesRepository.dart';
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