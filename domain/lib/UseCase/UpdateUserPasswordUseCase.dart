
import 'package:data/Repository/UserRepositoryImpl.dart';
import 'package:domain/Repository/UserRepository.dart';

UpdateUserPasswordUseCase injectUpdateUserPasswordUseCase(){
  return UpdateUserPasswordUseCase(repository: injectUserRepo());
}

class UpdateUserPasswordUseCase {

  UserRepository repository;
  UpdateUserPasswordUseCase({required this.repository});

  Future<void> invoke({required String email , required String password , required String newPassword}) async{

    await repository.updatePassword(email: email, password: password, newPassword: newPassword);

  }

}