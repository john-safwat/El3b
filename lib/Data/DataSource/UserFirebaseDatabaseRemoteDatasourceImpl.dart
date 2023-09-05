import 'dart:async';

import 'package:El3b/Data/Error/FirebaseErrorHandler.dart';
import 'package:El3b/Data/Firebase/UserFirebaseDatabase.dart';
import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:El3b/Domain/DataSource/UserFirebaseDatabaseRemoteDatasource.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
UserFirebaseDatabaseRemoteDatasource getUserFirebaseDatabaseRemoteDatasource() {
  return UserFirebaseDatabaseRemoteDatasourceImpl(
      userFirebaseDatabase: injectUserFirebaseDatabase(), errorHandler: injectFirebaseErrorHandler());
}

class UserFirebaseDatabaseRemoteDatasourceImpl implements UserFirebaseDatabaseRemoteDatasource{

  UserFirebaseDatabase userFirebaseDatabase ;
  FirebaseErrorHandler errorHandler;
  UserFirebaseDatabaseRemoteDatasourceImpl({required this.userFirebaseDatabase , required this.errorHandler});

  // create new user if user collection in firebase fireStore
  @override
  Future<void> createUser({required UserDTO user , required String uid}) async{
    try{
      await userFirebaseDatabase.createUser(user: user , uid: uid).timeout(const Duration(seconds: 60));
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
    }on FirebaseException catch(e){
      throw FirebaseUserDatabaseException(errorMessage: errorHandler.handleFirebaseFireStoreError(e.code));
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
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
    }on FirebaseException catch(e){
      throw FirebaseUserDatabaseException(errorMessage: errorHandler.handleFirebaseFireStoreError(e.code));
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
      throw FirebaseUserDatabaseException(errorMessage: errorHandler.handleFirebaseFireStoreError(e.code));
    }on TimeoutException {
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }



}