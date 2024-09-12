import 'package:data/Repository/UserRepositoryImpl.dart';
import 'package:domain/Repository/UserRepository.dart';


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