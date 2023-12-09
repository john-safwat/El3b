import 'package:El3b/Data/Models/Messages/MessageDTO.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';

abstract class MessagesRemoteDataSource {

  Future<Message> sendMessage({required MessageDTO message});

}