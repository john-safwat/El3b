import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseUserAuthRemoteDatasource {

  Future<User> createUser({UserDTO user});

}