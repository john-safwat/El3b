import 'package:El3b/Data/DataSource/MessagesRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/MessagesRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:El3b/Domain/Repository/MessagesRepository.dart';

MessagesRepository injectMessagesRepository(){
  return MessagesRepositoryImpl(remoteDataSource: injectMessagesRemoteDataSource());
}

class MessagesRepositoryImpl implements MessagesRepository{

  MessagesRemoteDataSource remoteDataSource;
  MessagesRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Message> sendMessage({required Message message}) async{
    var response = await remoteDataSource.sendMessage(message: message.toDatasource());
    return response;
  }

}