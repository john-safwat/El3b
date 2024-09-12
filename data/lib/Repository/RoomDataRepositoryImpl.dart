
import 'package:data/DataSource/firebase_images_remote_datasource_impl.dart';
import 'package:data/DataSource/room_data_remote_data_source_impl.dart';
import 'package:data/Models/Room/room_dto.dart';
import 'package:domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:domain/DataSource/RoomDataRemoteDataSource.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:domain/Repository/RoomDataRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

RoomDataRepository injectRoomDataRepository(){
  return RoomDataRepositoryImpl(
    dataSource: injectRoomDataRemoteDataSource(),
    imagesRemoteDatasource: injectFirebaseImagesRemoteDatasource()
  );
}

class RoomDataRepositoryImpl implements RoomDataRepository{

  RoomDataRemoteDataSource dataSource ;
  FirebaseImagesRemoteDatasource imagesRemoteDatasource;
  RoomDataRepositoryImpl({required this.dataSource , required this.imagesRemoteDatasource});

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

  @override
  Future<String> uploadImage({required XFile file}) async{
    var image = await imagesRemoteDatasource.uploadImage(file: file);
    return image;
  }

}