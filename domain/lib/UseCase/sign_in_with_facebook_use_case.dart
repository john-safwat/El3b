import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dependency injection
SignInWithFacebookUseCase injectSignInWithFacebookUseCase(){
  return SignInWithFacebookUseCase(repository: injectUserRepo());
}

// the object
class SignInWithFacebookUseCase {

  UserRepository repository;
  SignInWithFacebookUseCase({required this.repository});

  Future<User> invoke()async{
    var response = await repository.signInWithFacebook();
    return response;
  }

}