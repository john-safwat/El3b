
import 'package:data/Repository/room_data_repository_impl.dart';
import 'package:data/Repository/room_user_repository_impl.dart';
import 'package:domain/Models/Room/room.dart';
import 'package:domain/Repository/room_data_repository.dart';
import 'package:domain/Repository/room_user_repository.dart';
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