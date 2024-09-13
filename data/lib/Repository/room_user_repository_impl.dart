import 'package:data/DataSource/room_user_remote_data_source_impl.dart';
import 'package:data/Models/User/user_dto.dart';
import 'package:domain/DataSource/room_user_remote_data_source.dart';
import 'package:domain/Models/User/my_user.dart';
import 'package:domain/Repository/room_user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
RoomUserRepository injectRoomUserRepository(){
  return RoomUserRepositoryImpl(remoteDataSource: injectRoomUserRemoteDataSource());
}

class RoomUserRepositoryImpl implements RoomUserRepository {


  RoomUserRemoteDataSource remoteDataSource;
  RoomUserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> addUser(String roomId, User user) async{
    var response = await remoteDataSource.addUser(roomId: roomId,user: UserDTO(name: user.displayName??"", email: user.email??"", password: "Private", image: user.photoURL??"", phoneNumber: user.phoneNumber??"", bio: "bio", birthDate: "birthDate"), uid: user.uid);
    return response;
  }

  @override
  Future<String> removeUser(String roomId, String userId) async{
    var response =  await remoteDataSource.removeUser(roomId, userId);
    return response;
  }

  @override
  Future<List<MyUser>> getUsersList(String roomId) async{
    var response = await remoteDataSource.getUsersList(roomId);
    return response;
  }

}