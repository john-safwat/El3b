import 'package:El3b/Data/Models/Messages/MessageDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseMessagesDatabase injectFirebaseMessagesDatabase(){
  return FirebaseMessagesDatabase.getInstance();
}

class FirebaseMessagesDatabase {


  FirebaseMessagesDatabase._();
  static FirebaseMessagesDatabase? instance;
  static getInstance(){
    return instance ??= FirebaseMessagesDatabase._();
  }

  final _firebaseStorage = FirebaseStorage.instance;

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

  Future<MessageDTO> sendMessages(MessageDTO message)async{
    var ref = getCollectionReference(message.roomId);
    var doc  =ref.doc();
    message.messageId = doc.id;
    await doc.set(message);
    return message ;
  }

  Stream<QuerySnapshot<MessageDTO>> getMessagesStream({required String roomId}){
    return getCollectionReference(roomId).snapshots();
  }

}