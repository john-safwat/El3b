
import 'package:data/Models/Room/room_dto.dart';
import 'package:data/Repository/room_data_repository_impl.dart';
import 'package:domain/Repository/room_data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// dependency injection
GetUserRoomsUseCase injectGetUserRoomsUseCase(){
  return GetUserRoomsUseCase(injectRoomDataRepository());
}

class GetUserRoomsUseCase {

  RoomDataRepository repository;
  GetUserRoomsUseCase(this.repository);

  Stream<QuerySnapshot<RoomDTO>> invoke(String uid){
    return repository.getUserRooms(uid);
  }

}