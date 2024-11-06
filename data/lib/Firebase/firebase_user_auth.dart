import 'package:data/Models/User/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// dependency injection
FirebaseUserAuth injectFirebaseUserAuth() {
  return FirebaseUserAuth.getInstance();
}

// the object
class FirebaseUserAuth {
  FirebaseUserAuth._();

  static FirebaseUserAuth? instance;

  static getInstance() {
    return instance ??= FirebaseUserAuth._();
  }

  final _firebase = FirebaseAuth.instance;

  // function to create user in firebase auth
  Future<User> createUser({required UserDTO user}) async {
    await _firebase
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((value) => value.user!.updateDisplayName(user.name));
    return _firebase.currentUser!;
  }

  // function to update user photo in firebase auth
  Future<User> updateUserPhoto(String photo) async {
    await _firebase.currentUser!.updatePhotoURL(photo);
    return _firebase.currentUser!;
  }

  // function to update user name in firebase auth
  Future<User> updateUserDisplayName(String name) async {
    await _firebase.currentUser!.updateDisplayName(name);
    return _firebase.currentUser!;
  }

  // sign in user with email and password to firebase auth
  Future<User> signInUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebase.signInWithEmailAndPassword(
        email: email, password: password);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("loggedIn", true);
    return _firebase.currentUser!;
  }

  // function to send reset password email to the user when forget password
  Future<void> resetPassword({required String email}) async {
    await _firebase.sendPasswordResetEmail(email: email);
  }

  // login the user using google account
  Future<User> signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final user = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _firebase.signInWithCredential(user);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("loggedIn", true);
    return _firebase.currentUser!;
  }

  // login user with facebook
  Future<User> signInWithFacebook() async {
    // await FacebookAuth.instance.logOut();
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("loggedIn", true);
    return _firebase.currentUser!;
  }

  // function to sign user out
  Future<void> signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("loggedIn", false);
    await _firebase.signOut();
  }

  Future<void> updatePassword(
      {required String email,
      required String password,
      required String newPassword}) async {
    await _firebase.signInWithEmailAndPassword(email: email, password: password);
    await _firebase.currentUser!.updatePassword(newPassword);
  }
}
