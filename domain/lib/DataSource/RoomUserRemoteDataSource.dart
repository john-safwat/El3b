
import 'package:data/Models/User/user_dto.dart';
import 'package:domain/Models/User/MyUser.dart';

abstract class RoomUserRemoteDataSource {

  Future<String> addUser({required String roomId,required UserDTO user ,required String uid});
  Future<String> removeUser(String roomId , String userId);
  Future<List<MyUser>> getUsersList(String roomId);
}