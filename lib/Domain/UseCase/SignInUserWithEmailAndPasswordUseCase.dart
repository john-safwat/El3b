import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dependency injection
SignInUserWithEmailAndPasswordUseCase injectSignInUserWithEmailAndPasswordUseCase(){
  return SignInUserWithEmailAndPasswordUseCase(repository: injectUserRepo());
}

// the object
class SignInUserWithEmailAndPasswordUseCase {

  UserRepository repository;
  SignInUserWithEmailAndPasswordUseCase({required this.repository});

  Future<User> invoke({required String email , required String password})async{

    var response = await repository.signInWithEmailAndPassword(email: email, password: password);
    return response;

  }

}