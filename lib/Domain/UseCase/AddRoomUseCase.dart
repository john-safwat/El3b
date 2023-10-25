
import 'package:El3b/Data/Repository/RoomDataRepositoryImpl.dart';
import 'package:El3b/Data/Repository/RoomUserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/Repository/RoomDataRepository.dart';
import 'package:El3b/Domain/Repository/RoomUserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';


AddRoomUseCase injectAddRoomUseCase(){
  return AddRoomUseCase(repository: injectRoomDataRepository() , usersRepository: injectRoomUserRepository());
}

class AddRoomUseCase {
  RoomDataRepository repository ;
  RoomUserRepository usersRepository;
  AddRoomUseCase({required this.repository , required this.usersRepository});

  Future<String> invoke(String id , String name , String description ,
      String type , String ownerId ,int dateTime , User user , String uid)async{
    var response  = await repository.addRoom(
        Room(
            id: id,
            name: name,
            description: description,
            type: type,
            ownerId: ownerId,
            users:[ownerId],
            dateTime: dateTime
        ));
    var userResponse = await usersRepository.addUser(response, user);
    return "Room Created Successfully";
  }

}