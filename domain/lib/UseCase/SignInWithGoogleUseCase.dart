import 'package:data/Repository/UserRepositoryImpl.dart';
import 'package:domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dependency injection
SignInWithGoogleUseCase injectSignInWithGoogleUseCase(){
  return SignInWithGoogleUseCase(repository: injectUserRepo());
}

// the object
class SignInWithGoogleUseCase {
  UserRepository repository;
  SignInWithGoogleUseCase({required this.repository}) ;

  Future<User> invoke() async {
    var response = await repository.singInWithGoogle();
    return response ;
  }
}