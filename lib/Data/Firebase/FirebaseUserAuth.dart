import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserAuth {

  FirebaseUserAuth._();
  static FirebaseUserAuth? instance;
  static getFirebaseUserAuth(){
    return instance ??= FirebaseUserAuth._();
  }

  final _firebase = FirebaseAuth.instance;

  // function to create user in firebase auth
  Future<User> createUser({required UserDTO user}) async {
    var userCredential = await _firebase
        .createUserWithEmailAndPassword(email: user.email, password: user.name)
        .then((userCredential) async {
      await userCredential.user!.updateDisplayName(user.name);
      await userCredential.user!.updatePhotoURL(user.image);
      return userCredential.user!;
    });

    return userCredential;
  }

}
