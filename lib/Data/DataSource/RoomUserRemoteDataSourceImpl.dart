import 'dart:async';

import 'package:El3b/Data/Error/FirebaseErrorHandler.dart';
import 'package:El3b/Data/Firebase/RoomUsersDataBase.dart';
import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:El3b/Domain/DataSource/RoomUserRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
RoomUserRemoteDataSource injectRoomUserRemoteDataSource(){
  return RoomUserRemoteDataSourceImpl(errorHandler: injectFirebaseErrorHandler(), database: injectRoomUsersDatabase());
}

class RoomUserRemoteDataSourceImpl implements RoomUserRemoteDataSource {

  RoomUsersDatabase database ;
  FirebaseErrorHandler errorHandler;
  RoomUserRemoteDataSourceImpl({required this.errorHandler , required this.database});

  @override
  Future<String> addUser({required String roomId,required UserDTO user ,required String uid}) async{
    try{
      await database.addRoomMember(roomId, user , uid);
      return "User Added Successfully";
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
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
    } on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
    }on TimeoutException{
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<List<MyUser>> getUsersList(String roomId) async{
    var response = await database.getRoomUsersList(roomId);
    return response.map((e) => e.toDomain()).toList();
  }
  
} 