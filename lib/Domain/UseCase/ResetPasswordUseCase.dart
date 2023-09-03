// dependency injection
import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';

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