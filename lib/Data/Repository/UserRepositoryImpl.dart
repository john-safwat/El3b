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

  @override
  Future<User> createUser({XFile? file, required MyUser myUser}) async {
    if(file!= null){
      var image = await imagesRemoteDatasource.uploadUserProfileImage(file: file);
      myUser.image = image;
    }
    var user = await authRemoteDatasource.createUser(user: myUser.toDataSource());
    await userFirebaseDatabaseRemoteDatasource.createUser(
        user: myUser.toDataSource(), uid: user.uid);

    return user;
  }
}
