import 'dart:async';

import 'package:data/Firebase/firebase_user_database.dart';
import 'package:data/Models/User/user_dto.dart';
import 'package:domain/DataSource/UserFirebaseDatabaseRemoteDatasource.dart';
import 'package:domain/Exception/FirebaseUserAuthException.dart';
import 'package:domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:domain/Models/User/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
UserFirebaseDatabaseRemoteDatasource getUserFirebaseDatabaseRemoteDatasource() {
  return UserFirebaseDatabaseRemoteDatasourceImpl(
      userFirebaseDatabase: injectFirebaseUserDatabase());
}

class UserFirebaseDatabaseRemoteDatasourceImpl implements UserFirebaseDatabaseRemoteDatasource{

  FirebaseUserDatabase userFirebaseDatabase ;
  UserFirebaseDatabaseRemoteDatasourceImpl({required this.userFirebaseDatabase });

  // create new user if user collection in firebase fireStore
  @override
  Future<void> createUser({required UserDTO user , required String uid}) async{
    try{
      await userFirebaseDatabase.createUser(user: user , uid: uid).timeout(const Duration(seconds: 60));
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  // update user data in firebase storage
  @override
  Future<void> updateUser({required UserDTO user, required String uid}) async{
    try{
      await userFirebaseDatabase.updateUserData(user: user , uid: uid).timeout(const Duration(seconds: 60));
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }


  // function to check if user exists in database or not
  @override
  Future<bool> userExist({required String uid})async {
    try {
      var response = await userFirebaseDatabase.userExist(uid: uid);
      return response;
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage: e.code);
    }on TimeoutException {
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }


  // function to load data from user database
  @override
  Future<MyUser?> getUser({required String uid})async {
    try{
      var response = await userFirebaseDatabase.getUserData(uid: uid).timeout(const Duration(seconds: 60));
      return response?.toDomain();
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on FirebaseException catch(e){
      throw FirebaseFireStoreDatabaseException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }



}