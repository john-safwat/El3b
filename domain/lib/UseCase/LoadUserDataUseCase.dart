
import 'package:data/Repository/UserRepositoryImpl.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:domain/Repository/UserRepository.dart';



// dependency injection
LoadUserDataUseCase injectLoadUserDataUseCase(){
  return LoadUserDataUseCase(repository: injectUserRepo());
}


class LoadUserDataUseCase {

  UserRepository repository;
  LoadUserDataUseCase({required this.repository});

  Future<MyUser?> invoke({required String uid})async{
    var response = await repository.getUser(uid: uid);
    return response;
  }

}