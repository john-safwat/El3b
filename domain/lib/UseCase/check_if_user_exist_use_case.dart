import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Repository/user_repository.dart';

// dependency injection
CheckIfUserExistUseCase injectCheckIfUserExistUseCase(){
  return CheckIfUserExistUseCase(repository: injectUserRepo());
}

// the object
class CheckIfUserExistUseCase {

  UserRepository repository;
  CheckIfUserExistUseCase ({required this.repository});

  Future<bool> invoke({required String uid})async {
    var response = await repository.userExist(uid: uid);
    return response;
  }
}