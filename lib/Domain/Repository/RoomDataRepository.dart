import 'package:El3b/Data/Models/Room/RoomDTO.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RoomDataRepository{
  Future<String> addRoom(Room room);
  Stream<QuerySnapshot<RoomDTO>>getPublicRooms();
  Stream<QuerySnapshot<RoomDTO>>getUserRooms(String uid);
  Future<String> updateRoomMembers(Room room);
  Future<Room> getRoomById(String roomId);
  Future<List<Room>> getRoomsForSearch(String query);
  Future<String> deleteRoom(String roomId);
  Future<void> updateRoomData(Room room);
}