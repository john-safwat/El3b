
import 'package:data/Repository/RoomDataRepositoryImpl.dart';
import 'package:data/Repository/RoomUserRepositoryImpl.dart';
import 'package:domain/Models/Room/Room.dart';
import 'package:domain/Repository/RoomDataRepository.dart';
import 'package:domain/Repository/RoomUserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';


AddRoomUseCase injectAddRoomUseCase(){
  return AddRoomUseCase(repository: injectRoomDataRepository() , usersRepository: injectRoomUserRepository());
}

class AddRoomUseCase {
  RoomDataRepository repository ;
  RoomUserRepository usersRepository;
  AddRoomUseCase({required this.repository , required this.usersRepository});

  Future<String> invoke(String id , String name , String description , XFile? file,
      String type , String ownerId ,int dateTime , User user , String uid)async{

    var image = "";

    if(file != null){
      image = await repository.uploadImage(file: file);
    }

    var response  = await repository.addRoom(
        Room(
            id: id,
            name: name,
            description: description,
            image:  image,
            type: type,
            ownerId: ownerId,
            users:[ownerId],
            dateTime: dateTime
        ));
    var userResponse = await usersRepository.addUser(response, user);
    return "Room Created Successfully";
  }

}