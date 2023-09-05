import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';

// dependency injection
AddUserUseCase injectAddUserUseCase(){
  return AddUserUseCase(repository: injectUserRepo());
}

class AddUserUseCase {

  UserRepository repository ;
  AddUserUseCase({required this.repository});

  Future<void> invoke({required String uid , required MyUser myUser})async{
    await repository.createUserFirebaseFireStore(uid: uid, myUser: myUser);
  }

}