import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dependency injection
FirebaseUserAuth injectFirebaseUserAuth(){
  return FirebaseUserAuth.getFirebaseUserAuth();
}

// the object
class FirebaseUserAuth {

  FirebaseUserAuth._();
  static FirebaseUserAuth? instance;
  static getFirebaseUserAuth(){
    return instance ??= FirebaseUserAuth._();
  }

  final _firebase = FirebaseAuth.instance;

  // function to create user in firebase auth
  Future<void> createUser({required UserDTO user}) async {
    await _firebase.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password).then((value) => value.user!.updateDisplayName(user.name));
  }

  // function to update user photo in firebase auth
  Future<User> updateUserPhoto(String photo)async{
    await _firebase.currentUser!.updatePhotoURL(photo);
    return _firebase.currentUser!;
  }

}
