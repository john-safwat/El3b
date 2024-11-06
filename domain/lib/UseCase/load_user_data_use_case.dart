
import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Models/User/my_user.dart';
import 'package:domain/Repository/user_repository.dart';



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