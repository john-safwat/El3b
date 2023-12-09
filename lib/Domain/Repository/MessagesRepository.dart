import 'package:El3b/Domain/Models/Messages/Message.dart';

abstract class MessagesRepository {

  Future<Message> sendMessage({required Message message});

}