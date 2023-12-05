import 'dart:async';

import 'package:El3b/Data/Firebase/RoomUsersDataBase.dart';
import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:El3b/Domain/DataSource/RoomUserRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
RoomUserRemoteDataSource injectRoomUserRemoteDataSource(){
  return RoomUserRemoteDataSourceImpl( database: injectRoomUsersDatabase());
}

class RoomUserRemoteDataSourceImpl implements RoomUserRemoteDataSource {

  RoomUsersDatabase database ;
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