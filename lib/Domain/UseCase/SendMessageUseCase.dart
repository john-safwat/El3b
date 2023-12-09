import 'package:El3b/Data/Repository/MessagesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:El3b/Domain/Repository/MessagesRepository.dart';
import 'package:image_picker/image_picker.dart';

SendMessageUseCase injectSendMessageUseCase(){
  return SendMessageUseCase(repository: injectMessagesRepository());
}

class SendMessageUseCase {

  MessagesRepository repository;

  SendMessageUseCase({required this.repository});

  Future<Message> invoke({required Message message , XFile? image})async{
    var response = await repository.sendMessage(message: message , image: image);
    return response;
  }

}