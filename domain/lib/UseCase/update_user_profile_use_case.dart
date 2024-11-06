
import 'package:data/Repository/user_repository_impl.dart';
import 'package:domain/Models/User/my_user.dart';
import 'package:domain/Repository/user_repository.dart';
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