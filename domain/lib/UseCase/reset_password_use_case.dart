import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Repository/user_repository.dart';

// dependency injection
ResetPasswordUseCase injectResetPasswordUseCase(){
  return ResetPasswordUseCase(repository: injectUserRepo());
}

// he object
class ResetPasswordUseCase {
  UserRepository repository ;
  ResetPasswordUseCase({required this.repository});

  Future<void> invoke({required String email})async{
    await repository.resetPasswordWithEmail(email: email);
  }

}