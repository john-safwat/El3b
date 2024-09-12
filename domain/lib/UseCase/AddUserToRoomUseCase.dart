
import 'package:data/Repository/RoomDataRepositoryImpl.dart';
import 'package:data/Repository/RoomUserRepositoryImpl.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:domain/Repository/RoomDataRepository.dart';
import 'package:domain/Repository/RoomUserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
AddUserToRoomUseCase injectAddUserToRoomUseCase(){
  return AddUserToRoomUseCase(repository: injectRoomDataRepository() , usersRepository: injectRoomUserRepository());
}

class AddUserToRoomUseCase {

  RoomDataRepository repository;
  RoomUserRepository usersRepository;
  AddUserToRoomUseCase({required this.repository ,required this.usersRepository});

  Future<String> invoke(Room room , User user)async{
    room.users.add(user.uid);
    var response = await repository.updateRoomMembers(room);
    var userResponse = await usersRepository.addUser(room.id, user);

    return response;
  }

}