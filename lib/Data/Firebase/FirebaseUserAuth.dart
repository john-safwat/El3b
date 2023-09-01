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
  Future<User> createUser({required UserDTO user}) async {
    await _firebase.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password).then((value) => value.user!.updatePhotoURL(user.image));
    await updateUserDisplayName(user.name);
    return _firebase.currentUser!;
  }

  Future<void> updateUserDisplayName(String name)async{
    await _firebase.currentUser!.updateDisplayName(name);
  }

}
