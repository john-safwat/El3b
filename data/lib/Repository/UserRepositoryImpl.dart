import 'package:data/DataSource/firebase_images_remote_datasource_impl.dart';
import 'package:data/DataSource/firebase_user_auth_remote_datasource_impl.dart';
import 'package:data/DataSource/user_firebase_database_remote_datasource_impl.dart';
import 'package:domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:domain/DataSource/FirebaseUserAuthRemoteDatasource.dart';
import 'package:domain/DataSource/UserFirebaseDatabaseRemoteDatasource.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

// inject the user repo
UserRepository injectUserRepo() {
  return UserRepositoryImpl(
      imagesRemoteDatasource: injectFirebaseImagesRemoteDatasource(),
      authRemoteDatasource: getFirebaseUserAuthRemoteDatasource(),
      userFirebaseDatabaseRemoteDatasource:getUserFirebaseDatabaseRemoteDatasource());
}

// the object
class UserRepositoryImpl implements UserRepository {
  FirebaseImagesRemoteDatasource imagesRemoteDatasource;
  FirebaseUserAuthRemoteDatasource authRemoteDatasource;
  UserFirebaseDatabaseRemoteDatasource userFirebaseDatabaseRemoteDatasource;

  UserRepositoryImpl(
      {required this.imagesRemoteDatasource,
      required this.authRemoteDatasource,
      required this.userFirebaseDatabaseRemoteDatasource});

  // function to create user
  // 1 - create user account in firebase auth
  @override
  Future<User> createUserFireBaseAuth({required MyUser user})async{
    var response = await authRemoteDatasource.createUser(user: user.toDataSource());
    return response;
  }
  // 2 - if there is no exceptions it will upload the user image to firebase storage (if user picked image)
  @override
  Future<String> uploadUserImage({required XFile file})async{
    var image = await imagesRemoteDatasource.uploadImage(file: file);
    return image;
  }
  // 3 - update user image in firebase auth
  @override
  Future<User> updateUserPhotoUrl({required String image})async{
    var user = await authRemoteDatasource.updatePhotoUrl(photo: image);
    return user;
  }
  // 4 - create user in firebase database to hold all users data
  @override
  Future<void> createUserFirebaseFireStore({required String uid, required MyUser myUser}) async {
    await userFirebaseDatabaseRemoteDatasource.createUser(user: myUser.toDataSource(), uid: uid);
  }

  // function to update user data in firebase fireStore database
  @override
  Future<String> updateUserData({required MyUser myUser, required String uid}) async{
    await userFirebaseDatabaseRemoteDatasource.updateUser(user: myUser.toDataSource(), uid: uid);
    return "Your Data Updated Successfully";
  }

  // function to sign in user using email ana password 
  @override
  Future<User> signInWithEmailAndPassword({required String email, required String password}) async{
    var response = await authRemoteDatasource.signInWithEmailAndPassword(email: email, password: password);
    return response;
  }

  // function to reset user password
  @override
  Future<void> resetPasswordWithEmail({required String email}) async{
    await authRemoteDatasource.resetPasswordWithEmail(email: email);
  }

  // function to check if user exist in database
  @override
  Future<bool> userExist({required String uid}) async{
    var response = await userFirebaseDatabaseRemoteDatasource.userExist(uid: uid);
    return response;
  }

  // function to sign in with google
  @override
  Future<User> singInWithGoogle() async{
    var response = await authRemoteDatasource.signInWithGoogle();
    return response;
  }

  // function to sign in with facebook
  @override
  Future<User> signInWithFacebook() async{
    var response = await authRemoteDatasource.signInWithFacebook();
    return response;
  }

  @override
  Future<void> signOutUser() async{
    await authRemoteDatasource.signOutUser();
  }

  // function to load to user data from firebase fire storage
  @override
  Future<MyUser?> getUser({required String uid}) async{
    var response = await userFirebaseDatabaseRemoteDatasource.getUser(uid: uid);
    return response;
  }

  @override
  Future<String> updateUserProfileImage({required XFile file, required String url})async {
    if(url.isEmpty){
      var image = await imagesRemoteDatasource.uploadImage(file: file);
      return image;
    }else {
      var image = await imagesRemoteDatasource.updateImage(file: file , url: url);
      return image;
    }
  }

  @override
  Future<User> updateUserDisplayName({required String name}) async{
    var response = await authRemoteDatasource.updateUserDisplayName(name: name);
    return response;
  }

  @override
  Future<void> updatePassword({required String email, required String password, required String newPassword}) async{
    await authRemoteDatasource.updatePassword(email: email, password: password, newPassword: newPassword);
  }
}
