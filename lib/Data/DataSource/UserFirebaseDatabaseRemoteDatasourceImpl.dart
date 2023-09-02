import 'dart:async';

import 'package:El3b/Data/Error%20Handler/ErrorHandler.dart';
import 'package:El3b/Data/Firebase/UserFirebaseDatabase.dart';
import 'package:El3b/Data/Models/User/UserDTO.dart';
import 'package:El3b/Domain/DataSource/UserFirebaseDatabaseRemoteDatasource.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:firebase_auth/firebase_auth.dart';


// dependency injection
UserFirebaseDatabaseRemoteDatasource getUserFirebaseDatabaseRemoteDatasource() {
  return UserFirebaseDatabaseRemoteDatasourceImpl(
      userFirebaseDatabase: injectUserFirebaseDatabase(), errorHandler: injectErrorHandler());
}

class UserFirebaseDatabaseRemoteDatasourceImpl implements UserFirebaseDatabaseRemoteDatasource{

  UserFirebaseDatabase userFirebaseDatabase ;
  ErrorHandler errorHandler;
  UserFirebaseDatabaseRemoteDatasourceImpl({required this.userFirebaseDatabase , required this.errorHandler});

  // create new user if user collection in firebase fireStore
  @override
  Future<void> createUser({required UserDTO user , required String uid}) async{
    try{
      await userFirebaseDatabase.createUser(user: user , uid: uid).timeout(const Duration(seconds: 60));
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseFireStoreError(e.code));
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
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseFireStoreError(e.code));
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }



}