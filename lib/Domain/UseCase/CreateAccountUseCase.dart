import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

CreateAccountUseCase injectCreateAccountUseCase() {
  return CreateAccountUseCase(repository: injectUserRepo());
}

// the object
class CreateAccountUseCase {
  UserRepository repository;
  CreateAccountUseCase({required this.repository});

  Future<User> invoke({XFile? image, required MyUser user}) async {
    var response = await repository.createUser(
        file: image,
        myUser: user);
    return response;
  }
}
