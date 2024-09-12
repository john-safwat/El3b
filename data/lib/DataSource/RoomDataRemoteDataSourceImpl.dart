import 'dart:async';

import 'package:data/Firebase/FirebaseRoomsDatabase.dart';
import 'package:data/Models/Room/RoomDTO.dart';
import 'package:domain/DataSource/RoomDataRemoteDataSource.dart';
import 'package:domain/Exception/FirebaseUserAuthException.dart';
import 'package:domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
RoomDataRemoteDataSource injectRoomDataRemoteDataSource(){
  return RoomDataRemoteDataSourceImpl(
    database: injectFirebaseRoomsDatabase()
  );
}

class RoomDataRemoteDataSourceImpl implements RoomDataRemoteDataSource{
  FirebaseRoomsDatabase database;
  RoomDataRemoteDataSourceImpl({required this.database});

  @override
  Future<String> addRoom(RoomDTO room) async {
    try{
      var response = await database.addRoom(room).timeout(const Duration(seconds: 15));
      return response;
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Stream<QuerySnapshot<RoomDTO>> getPublicRooms() {
    return database.getPublicRooms();
  }

  @override
  Future<String> updateRoomMembers(RoomDTO room) async{
    try{
      await database.updateRoomData(room).timeout(const Duration(seconds: 15));
      return "Welcome\nYou Joint Successfully";
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage:e.code);
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Stream<QuerySnapshot<RoomDTO>> getUserRooms(String uid) {
    return database.getUserRooms(uid);
  }

  @override
  Future<Room> getRoomById(String roomId) async{
    try{
      var response  = await database.getRoomById(roomId);
      return response.toDomain();
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<List<Room>> getRoomsForSearch(String query) async{
    try{
      var response  = await database.getSearchRooms(query);
      return response.map((e) => e.toDomain()).toList();
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<String> deleteRoom(String roomId)async {
    try{
      await database.deleteRoom(roomId);
      return "Room Deleted successfully";
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<void> updateRoomData(RoomDTO room) async{
    try{
      await database.updateRoomData(room);
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage:  e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

}