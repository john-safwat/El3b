import 'package:data/Repository/UserRepositoryImpl.dart';
import 'package:domain/Repository/UserRepository.dart';

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