import 'package:data/Repository/MessagesRepositoryImpl.dart';
import 'package:domain/Models/Messages/Message.dart';
import 'package:domain/Repository/MessagesRepository.dart';
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