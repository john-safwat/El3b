import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

CreateAccountUseCase injectCreateAccountUseCase(){
  return CreateAccountUseCase(repository: injectUserRepo());
}

// the object
class CreateAccountUseCase {

  UserRepository repository;
  CreateAccountUseCase({required this.repository});

  Future<User> invoke({XFile? image , required String name , required String email , required String password})async{
    var response = await repository.createUser(file: image, myUser: MyUser(
        name: name,
        email: email,
        password: password,
        image: "",
        phoneNumber: "",
        bio: "",
        birthDate: DateTime.now())
    );
    return response;
  }

}