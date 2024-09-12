import 'package:data/Models/User/UserDTO.dart';
import 'package:domain/Models/User/MyUser.dart';

abstract class UserFirebaseDatabaseRemoteDatasource {

  Future<void> createUser({required UserDTO user , required String uid});
  Future<void> updateUser({required UserDTO user , required String uid});
  Future<bool> userExist({required String uid});
  Future<MyUser?> getUser({required String uid});
}