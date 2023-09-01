import 'package:El3b/Data/Models/User/UserDTO.dart';

abstract class UserFirebaseDatabaseRemoteDatasource {

  Future<void> createUser({required UserDTO user , required String uid});

}