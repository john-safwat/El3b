
import 'package:data/Models/Room/room_dto.dart';
import 'package:data/Repository/RoomDataRepositoryImpl.dart';
import 'package:domain/Repository/RoomDataRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// dependency injection
GetGeneralRoomsUseCase injectGetGeneralRoomsUseCase(){
  return GetGeneralRoomsUseCase(repository: injectRoomDataRepository());
}

class GetGeneralRoomsUseCase {

  RoomDataRepository repository;
  GetGeneralRoomsUseCase({required this.repository});

  Stream<QuerySnapshot<RoomDTO>> invoke(){
    return repository.getPublicRooms();
  }


}