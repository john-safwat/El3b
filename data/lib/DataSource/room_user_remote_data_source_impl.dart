import 'dart:async';

import 'package:data/Firebase/firebase_room_users_data_base.dart';
import 'package:data/Models/User/user_dto.dart';
import 'package:domain/DataSource/RoomUserRemoteDataSource.dart';
import 'package:domain/Exception/FirebaseUserAuthException.dart';
import 'package:domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:domain/Models/User/MyUser.dart';
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