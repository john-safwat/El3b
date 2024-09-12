import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Repository/user_repository.dart';
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