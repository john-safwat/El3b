
import 'package:El3b/Data/Models/Room/RoomDTO.dart';
import 'package:El3b/Data/Repository/RoomDataRepositoryImpl.dart';
import 'package:El3b/Domain/Repository/RoomDataRepository.dart';
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