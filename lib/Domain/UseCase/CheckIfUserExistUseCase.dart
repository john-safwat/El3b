import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';

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