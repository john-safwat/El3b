import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// dependency injection
UserFirebaseDatabase injectUserFirebaseDatabase(){
  return UserFirebaseDatabase.getUserFirebaseDatabase();
}

// the object
class UserFirebaseDatabase {

  UserFirebaseDatabase._();
  static UserFirebaseDatabase? instance;
  static getUserFirebaseDatabase(){
    return instance ??= UserFirebaseDatabase._();
  }

  // function to get the collection references for users collection
  CollectionReference<UserDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection("Users").withConverter(
        fromFirestore: (snapshot, options) => UserDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // function to upload user data to user data to database
  Future<void> createUser({required UserDTO user , required String uid}) async {
    await getCollectionReference().doc(uid).set(user);
  }

}