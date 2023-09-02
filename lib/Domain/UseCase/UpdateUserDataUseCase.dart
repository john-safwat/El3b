import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';

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