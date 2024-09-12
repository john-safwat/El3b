import 'package:data/DataSource/RoomUserRemoteDataSourceImpl.dart';
import 'package:data/Models/User/UserDTO.dart';
import 'package:domain/DataSource/RoomUserRemoteDataSource.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:domain/Repository/RoomUserRepository.dart';
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