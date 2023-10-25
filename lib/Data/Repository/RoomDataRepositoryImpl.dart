
import 'package:El3b/Data/DataSource/RoomDataRemoteDataSourceImpl.dart';
import 'package:El3b/Data/Models/Room/RoomDTO.dart';
import 'package:El3b/Domain/DataSource/RoomDataRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/Repository/RoomDataRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

RoomDataRepository injectRoomDataRepository(){
  return RoomDataRepositoryImpl(dataSource: injectRoomDataRemoteDataSource());
}

class RoomDataRepositoryImpl implements RoomDataRepository{

  RoomDataRemoteDataSource dataSource ;
  RoomDataRepositoryImpl({required this.dataSource});

  @override
  Future<String> addRoom(Room room) async{
    var response = await dataSource.addRoom(room.toDataSource());
    return response;
  }

  @override
  Stream<QuerySnapshot<RoomDTO>> getPublicRooms() {
    return dataSource.getPublicRooms();
  }

  @override
  Future<String> updateRoomMembers(Room room) async{
    var response = await dataSource.updateRoomMembers(room.toDataSource());
    return response;
  }

  @override
  Stream<QuerySnapshot<RoomDTO>> getUserRooms(String uid) {
    return dataSource.getUserRooms(uid);
  }

  @override
  Future<Room> getRoomById(String roomId) async{
    var response = await dataSource.getRoomById(roomId);
    return response;
  }

  @override
  Future<List<Room>> getRoomsForSearch(String query) async{
    var response = await dataSource.getRoomsForSearch(query);
    return response;
  }

  @override
  Future<String> deleteRoom(String roomId) async{
    var response = await dataSource.deleteRoom(roomId);
    return response;
  }

  @override
  Future<void> updateRoomData(Room room) async{
    await dataSource.updateRoomData(room.toDataSource());
  }

}