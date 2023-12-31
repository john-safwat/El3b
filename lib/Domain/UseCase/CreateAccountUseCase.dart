import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

// dependency injection
CreateAccountUseCase injectCreateAccountUseCase() {
  return CreateAccountUseCase(repository: injectUserRepo());
}

// the object
class CreateAccountUseCase {
  UserRepository repository;
  CreateAccountUseCase({required this.repository});

  Future<User> invoke({XFile? file, required MyUser user}) async {
    var response  = await repository.createUserFireBaseAuth(user: user);
    if(file!= null){
      var image = await repository.uploadUserImage(file: file);
      user.image = image;
      response = await repository.updateUserPhotoUrl(image: image);
    }
    user.password = "Private";
    await repository.createUserFirebaseFireStore(uid: response.uid, myUser: user);
    return response;
  }
}
