import 'package:El3b/Data/DataSource/FirebaseImagesRemoteDatasourceImpl.dart';
import 'package:El3b/Data/DataSource/FirebaseUserAuthRemoteDatasourceImpl.dart';
import 'package:El3b/Data/DataSource/UserFirebaseDatabaseRemoteDatasourceImpl.dart';
import 'package:El3b/Domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:El3b/Domain/DataSource/FirebaseUserAuthRemoteDatasource.dart';
import 'package:El3b/Domain/DataSource/UserFirebaseDatabaseRemoteDatasource.dart';
import 'package:El3b/Domain/Models/User/MyUser.dart';
import 'package:El3b/Domain/Repository/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

// inject the user repo
UserRepository injectUserRepo() {
  return UserRepositoryImpl(
      imagesRemoteDatasource: getFirebaseImagesRemoteDatasource(),
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
  // 2 - if there is no exceptions it will upload the user image to firebase storage (if user picked image)
  // 3 - update user image in firebase auth
  // 4 - create user in firebase database to hold all users data
  @override
  Future<User> createUser({XFile? file, required MyUser myUser}) async {
    // create user account in firebase auth
    await authRemoteDatasource.createUser(user: myUser.toDataSource());
    myUser.password = "Private";
    // if there is no exceptions it will upload the user image to firebase storage (if user picked image)
    if(file!= null){
      var image = await imagesRemoteDatasource.uploadUserProfileImage(file: file);
      myUser.image = image;
    }
    // update user image in firebase auth
    var user = await authRemoteDatasource.updatePhotoUrl(photo: myUser.image);
    // create user in firebase database to hold all users data
    await userFirebaseDatabaseRemoteDatasource.createUser(
        user: myUser.toDataSource(), uid: user.uid);

    return user;
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
}
