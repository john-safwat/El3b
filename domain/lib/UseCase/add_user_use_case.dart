import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Models/User/my_user.dart';
import 'package:domain/Repository/user_repository.dart';

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