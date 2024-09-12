
import 'package:data/Models/Room/RoomDTO.dart';
import 'package:data/Repository/RoomDataRepositoryImpl.dart';
import 'package:domain/Repository/RoomDataRepository.dart';
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