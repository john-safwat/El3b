import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        password: user.password).then((value) => value.user!.updateDisplayName(user.name));
    return _firebase.currentUser!;
  }

  // function to update user photo in firebase auth
  Future<User> updateUserPhoto(String photo)async{
    await _firebase.currentUser!.updatePhotoURL(photo);
    return _firebase.currentUser!;
  }

  // function to update user name in firebase auth
  Future<User> updateUserDisplayName(String name)async{
    await _firebase.currentUser!.updateDisplayName(name);
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

  // login the user using google account
  Future<User> signInWithGoogle()async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn()
        .signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!
        .authentication;
    final user = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _firebase.signInWithCredential(user);
    return _firebase.currentUser!;
  }

}
