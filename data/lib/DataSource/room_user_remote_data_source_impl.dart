import 'dart:async';

import 'package:data/Firebase/firebase_room_users_data_base.dart';
import 'package:data/Models/User/user_dto.dart';
import 'package:domain/DataSource/room_user_remote_data_source.dart';
import 'package:domain/Exception/firebase_user_auth_exception.dart';
import 'package:domain/Exception/firebase_user_database_exception.dart';
import 'package:domain/Exception/time_out_operations_exception.dart';
import 'package:domain/Exception/unknown_exception.dart';
import 'package:domain/Models/User/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
RoomUserRemoteDataSource injectRoomUserRemoteDataSource(){
  return RoomUserRemoteDataSourceImpl( database: injectFirebaseRoomUsersDataBase());
}

class RoomUserRemoteDataSourceImpl implements RoomUserRemoteDataSource {

  FirebaseRoomUsersDataBase database ;
  RoomUserRemoteDataSourceImpl({ required this.database});

  @override
  Future<String> addUser({required String roomId,required UserDTO user ,required String uid}) async{
    try{
      await database.addRoomMember(roomId, user , uid);
      return "User Added Successfully";
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException{
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<String> removeUser(String roomId, String userId)async {
    try{
      await database.removeRoomMember(roomId, userId);
      return "User Removed Successfully";
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException{
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<List<MyUser>> getUsersList(String roomId) async{
    try{
      var response = await database.getRoomUsersList(roomId);
      return response.map((e) => e.toDomain()).toList();
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException{
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }
  
} 