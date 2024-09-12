
import 'package:domain/Models/User/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RoomUserRepository {

  Future<String> addUser(String roomId , User user);
  Future<String> removeUser(String roomId , String userId);
  Future<List<MyUser>> getUsersList(String roomId);

}