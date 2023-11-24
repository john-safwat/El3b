import 'package:El3b/Data/Models/Messages/messageDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesDatabase {
  MessagesDatabase._();
  static MessagesDatabase? _instance;
  static MessagesDatabase getMessagesDatabase() {
    _instance ??= MessagesDatabase._();
    return _instance!;
  }

  CollectionReference<MessageDTO> getCollectionReference(String roomId) {
    return FirebaseFirestore.instance
        .collection("Rooms")
        .doc(roomId)
        .collection("Messages")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MessageDTO.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  Future<void> sendMessages(MessageDTO messageDTO)async{
      var ref = getCollectionReference(messageDTO.roomId);
      var doc  =ref.doc();
      messageDTO.messageId = doc.id;
      await doc.set(messageDTO);
  }
}
