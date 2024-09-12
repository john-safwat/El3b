
import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Repository/user_repository.dart';

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