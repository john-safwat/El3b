import 'package:core/Base/base_database.dart';
import 'package:data/Models/User/user_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// dependency injection
FirebaseUserDatabase injectFirebaseUserDatabase(){
  return FirebaseUserDatabase.getInstance();
}

// the object
class FirebaseUserDatabase extends BaseDatabase{

  FirebaseUserDatabase._();
  static FirebaseUserDatabase? instance;
  static getInstance(){
    return instance ??= FirebaseUserDatabase._();
  }

  // function to get the collection references for users collection
  CollectionReference<UserDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection(constants.userCollection).withConverter(
        fromFirestore: (snapshot, options) => UserDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // function to upload user data to user data to database
  Future<void> createUser({required UserDTO user , required String uid}) async {
    await getCollectionReference().doc(uid).set(user);
  }

  // function to update user data to user database in firebase fireStore
  Future<void> updateUserData({required UserDTO user , required String uid}) async {
    await getCollectionReference().doc(uid).update(user.toFireStore());
  }

  // function to check if user Exist in database
  Future<bool> userExist({required String uid})async{
    var doc  = await getCollectionReference().doc(uid).get();
    return doc.exists;
  }

  Future<UserDTO?> getUserData({required String uid})async {
    var doc = await getCollectionReference().doc(uid).get();
    return doc.data();
  }

}