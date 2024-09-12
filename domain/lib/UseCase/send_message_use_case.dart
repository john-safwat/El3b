import 'package:data/Repository/messages_repository_impl.dart';
import 'package:domain/Models/Messages/message.dart';
import 'package:domain/Repository/messages_repository.dart';
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