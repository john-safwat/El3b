import 'package:data/Repository/UserRepositoryImpl.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:domain/Repository/UserRepository.dart';

// dependency injection
UpdateUserDataUseCase injectUpdateUserDataUseCase(){
  return UpdateUserDataUseCase(repository: injectUserRepo());
}

// the object
class UpdateUserDataUseCase {

  UserRepository repository ;
  UpdateUserDataUseCase({required this.repository});

  Future<String> invoke({required MyUser user , required String uid})async{
    var response = await repository.updateUserData(myUser: user, uid: uid);
    return response;
  }

}