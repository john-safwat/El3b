import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';


// dependency injection
SignUserOutUseCase injectSignUserOutUseCase(){
  return SignUserOutUseCase(repository: injectUserRepo());
}

class SignUserOutUseCase{

  UserRepository repository;
  SignUserOutUseCase({required this.repository});

  Future<void> invoke()async{
    await repository.signOutUser();
  }

}