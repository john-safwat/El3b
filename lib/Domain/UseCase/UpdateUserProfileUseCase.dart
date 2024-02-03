
import 'package:El3b/Data/Repository/UserRepositoryImpl.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';



// dependency injection
UpdateUserProfileUseCase injectUpdateUserProfileUseCase(){
  return UpdateUserProfileUseCase(repository: injectUserRepo());
}

class UpdateUserProfileUseCase {

  UserRepository repository;
  UpdateUserProfileUseCase({required this.repository});


  Future<User> invoke({required MyUser user , XFile? file , required String uid})async{
    if(file!= null){
      var response = await repository.updateUserProfileImage(url: user.image,file: file);
      await repository.updateUserPhotoUrl(image: response);
      user.image = response;
    }
    var response = await repository.updateUserDisplayName(name: user.name);
    var exist = await repository.userExist(uid: uid);
    if (exist){
      await repository.updateUserData(myUser: user, uid: uid);
    }else {
      await repository.createUserFirebaseFireStore(myUser: user, uid: uid);
    }
    return response;
  }

}