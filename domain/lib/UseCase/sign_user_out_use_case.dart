import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Repository/user_repository.dart';


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