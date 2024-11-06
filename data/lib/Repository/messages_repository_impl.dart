import 'package:data/DataSource/firebase_images_remote_datasource_impl.dart';
import 'package:data/DataSource/messages_remote_data_source_impl.dart';
import 'package:data/Models/Messages/message_dto.dart';
import 'package:domain/DataSource/firebase_images_remote_datasource.dart';
import 'package:domain/DataSource/messages_remote_data_source.dart';
import 'package:domain/Models/Messages/message.dart';
import 'package:domain/Repository/messages_repository.dart';
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
