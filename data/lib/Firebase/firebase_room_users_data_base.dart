
import 'package:core/Base/base_database.dart';
import 'package:data/Models/User/user_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// dependency injection
FirebaseRoomUsersDataBase injectFirebaseRoomUsersDataBase(){
  return FirebaseRoomUsersDataBase.getInstance();
}

class FirebaseRoomUsersDataBase extends BaseDatabase{

  FirebaseRoomUsersDataBase._();
  static FirebaseRoomUsersDataBase? _instance;
  static FirebaseRoomUsersDataBase getInstance(){
    _instance ??= FirebaseRoomUsersDataBase._();
    return _instance!;
  }

  CollectionReference<UserDTO> getCollectionReference(String roomId) {
    return FirebaseFirestore.instance
        .collection(constants.roomsCollection)
        .doc(roomId)
        .collection(constants.userCollection)
        .withConverter(
      fromFirestore: (snapshot, options) => UserDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<void> addRoomMember(String roomId , UserDTO user , String uid)async {
    var ref = getCollectionReference(roomId);
    await ref.doc(uid).set(user);
  }

  Future<void> removeRoomMember(String roomId , String userId)async {
    var ref = getCollectionReference(roomId);
    await ref.doc(userId).delete();
  }

  Future<List<UserDTO>> getRoomUsersList(String roomId)async{
    var ref = getCollectionReference(roomId);
    var data = await ref.get();
    return data.docs.map((e) => e.data()).toList();
  }

}