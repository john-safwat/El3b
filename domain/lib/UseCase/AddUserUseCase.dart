import 'package:data/Repository/UserRepositoryImpl.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:domain/Repository/UserRepository.dart';

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