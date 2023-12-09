import 'package:El3b/Data/Repository/MessagesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:El3b/Domain/Repository/MessagesRepository.dart';

SendMessageUseCase injectSendMessageUseCase(){
  return SendMessageUseCase(repository: injectMessagesRepository());
}

class SendMessageUseCase {

  MessagesRepository repository;
  SendMessageUseCase({required this.repository});

  Future<Message> invoke({required Message message})async{
    var response = await repository.sendMessage(message: message);
    return response;
  }

}