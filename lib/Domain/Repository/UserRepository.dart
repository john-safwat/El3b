import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {

  Future<void> createUserFirebaseFireStore({required String uid, required MyUser myUser});
  Future<User> createUserFireBaseAuth({required MyUser user});
  Future<String> uploadUserImage({required XFile file});
  Future<User> updateUserPhotoUrl({required String image});
  Future<String> updateUserData({required MyUser myUser , required String uid});
  Future<User> signInWithEmailAndPassword({required String email , required String password});
  Future<void> resetPasswordWithEmail({required String email});
  Future<User> singInWithGoogle();
  Future<bool> userExist({required String uid});
}
