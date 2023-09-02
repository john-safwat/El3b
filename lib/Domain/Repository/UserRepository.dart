import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {

  Future<User> createUser({XFile? file , required MyUser myUser});
  Future<String> updateUserData({required MyUser myUser , required String uid});
}
