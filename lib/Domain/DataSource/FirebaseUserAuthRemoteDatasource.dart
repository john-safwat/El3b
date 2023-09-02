import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseUserAuthRemoteDatasource {

  Future<void> createUser({required UserDTO user});
  Future<User> updatePhotoUrl({required String photo});

}