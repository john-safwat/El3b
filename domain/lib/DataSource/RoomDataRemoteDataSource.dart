import 'package:data/Models/Room/RoomDTO.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RoomDataRemoteDataSource {
  Future<String> addRoom(RoomDTO room);
  Stream<QuerySnapshot<RoomDTO>>getPublicRooms();
  Stream<QuerySnapshot<RoomDTO>>getUserRooms(String uid);
  Future<String> updateRoomMembers(RoomDTO room);
  Future<Room> getRoomById(String roomId);
  Future<List<Room>> getRoomsForSearch(String query);
  Future<String> deleteRoom(String roomId);
  Future<void> updateRoomData(RoomDTO room);
}