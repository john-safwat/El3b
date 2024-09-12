import 'package:data/Models/Room/RoomDTO.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

abstract class RoomDataRepository{
  Future<String> addRoom(Room room);
  Future<String> uploadImage({required XFile file});
  Stream<QuerySnapshot<RoomDTO>>getPublicRooms();
  Stream<QuerySnapshot<RoomDTO>>getUserRooms(String uid);
  Future<String> updateRoomMembers(Room room);
  Future<Room> getRoomById(String roomId);
  Future<List<Room>> getRoomsForSearch(String query);
  Future<String> deleteRoom(String roomId);
  Future<void> updateRoomData(Room room);
}