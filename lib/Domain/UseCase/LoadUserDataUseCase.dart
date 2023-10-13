
import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';



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