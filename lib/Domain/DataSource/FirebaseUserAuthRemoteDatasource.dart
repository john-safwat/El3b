import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseUserAuthRemoteDatasource {

  Future<User> createUser({required UserDTO user});
  Future<User> updatePhotoUrl({required String photo});
  Future<User> signInWithEmailAndPassword({required String email , required String password});
  Future<void> resetPasswordWithEmail({required String email});
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> signOutUser();
  Future<User> updateUserDisplayName({required String name});
}