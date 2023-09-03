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

  // sign in user with email and password to firebase auth
  Future<User> signInUserWithEmailAndPassword({required String email , required String password}) async{
    await _firebase.signInWithEmailAndPassword(email: email, password: password);
    return _firebase.currentUser!;
  }

  // function to send reset password email to the user when forget password
  Future<void> resetPassword({required String email})async{
    await _firebase.sendPasswordResetEmail(email: email);
  }
}
