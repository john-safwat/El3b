import 'package:El3b/Data/DataSource/FirebaseImagesRemoteDatasourceImpl.dart';
import 'package:El3b/Data/DataSource/MessagesRemoteDataSourceImpl.dart';
import 'package:El3b/Data/Models/Messages/MessageDTO.dart';
import 'package:El3b/Domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:El3b/Domain/DataSource/MessagesRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:El3b/Domain/Repository/MessagesRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

MessagesRepository injectMessagesRepository() {
  return MessagesRepositoryImpl(
      remoteDataSource: injectMessagesRemoteDataSource(),
      firebaseImagesRemoteDatasource: injectFirebaseImagesRemoteDatasource());
}

class MessagesRepositoryImpl implements MessagesRepository {
  MessagesRemoteDataSource remoteDataSource;
  FirebaseImagesRemoteDatasource firebaseImagesRemoteDatasource;
  MessagesRepositoryImpl(
      {required this.remoteDataSource,
      required this.firebaseImagesRemoteDatasource});

  @override
  Future<Message> sendMessage({required Message message, XFile? image}) async {
    if (image != null) {
      var imageURL = await firebaseImagesRemoteDatasource.uploadImage(file: image);
      message.image = imageURL;
    }
    var response =
        await remoteDataSource.sendMessage(message: message.toDatasource());
    return response;
  }

  @override
  Stream<QuerySnapshot<MessageDTO>> readMessages({required String roomId}) {
    return remoteDataSource.readMessages(roomId: roomId);
  }

}
