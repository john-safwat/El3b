import 'dart:async';
import 'package:data/Firebase/firebase_user_auth.dart';
import 'package:data/Models/User/user_dto.dart';
import 'package:domain/DataSource/firebase_user_auth_remote_datasource.dart';
import 'package:domain/Exception/firebase_login_exception.dart';
import 'package:domain/Exception/firebase_user_auth_exception.dart';
import 'package:domain/Exception/time_out_operations_exception.dart';
import 'package:domain/Exception/unknown_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dependency injection
FirebaseUserAuthRemoteDatasource getFirebaseUserAuthRemoteDatasource() {
  return FirebaseUserAuthRemoteDatasourceImpl(
      firebaseUserAuth: injectFirebaseUserAuth());
}

// the object
class FirebaseUserAuthRemoteDatasourceImpl implements FirebaseUserAuthRemoteDatasource {

  FirebaseUserAuth firebaseUserAuth;
  FirebaseUserAuthRemoteDatasourceImpl ({required this.firebaseUserAuth});

  // function to create user account using firebase auth and handle any exceptions
  @override
  Future<User> createUser({required UserDTO user}) async{
    try{
      var response = await firebaseUserAuth.createUser(user: user).timeout(const Duration(seconds: 60));
      return response;
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  // function to update user photo URL
  @override
  Future<User> updatePhotoUrl({required String photo}) async{
    try{
      var response = await firebaseUserAuth.updateUserPhoto(photo).timeout(const Duration(seconds: 60));
      return response;
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage:  e.code);
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  // function to sign in user using email and password to firebase auth
  @override
  Future<User> signInWithEmailAndPassword({required String email, required String password}) async{
    try{
      var response = await firebaseUserAuth.signInUserWithEmailAndPassword(email: email , password: password).timeout(const Duration(seconds: 60));
      return response;
    }on FirebaseAuthException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }on FirebaseException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    }catch(e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  // function to reset User Password and handle any operation exception
  @override
  Future<void> resetPasswordWithEmail({required String email}) async{
    try{
      await firebaseUserAuth.resetPassword(email: email).timeout(const Duration(seconds: 60));
    }on FirebaseAuthException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }catch (e){
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  // function to sign user in using google auth
  @override
  Future<User> signInWithGoogle() async{
    try{
      var response = await firebaseUserAuth.signInWithGoogle().timeout(const Duration(seconds: 180));
      return response;
    }on FirebaseAuthException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }on FirebaseException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

  // function to sign the user in using facebook
  @override
  Future<User> signInWithFacebook() async{
    try{
      var response = await firebaseUserAuth.signInWithFacebook().timeout(const Duration(seconds: 180));
      return response;
    }on FirebaseAuthException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }on FirebaseException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> signOutUser() async{
    try{
      await firebaseUserAuth.signOut().timeout(const Duration(seconds: 180));
    }on FirebaseAuthException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }on FirebaseException catch(e){
      throw FirebaseLoginException(errorMessage: e.code);
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<User> updateUserDisplayName({required String name}) async{
    try{
      var response = await firebaseUserAuth.updateUserDisplayName(name).timeout(const Duration(seconds: 180));
      return response;
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> updatePassword({required String email, required String password, required String newPassword}) async{
    try{
      await firebaseUserAuth.updatePassword(email: email, password: password, newPassword: newPassword).timeout(const Duration(seconds: 180));
    }on FirebaseAuthException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }on TimeoutException catch(e){
      throw TimeOutOperationsException(errorMessage: "Operation Timed Out");
    }on FirebaseException catch(e){
      throw FirebaseUserAuthException(errorMessage: e.code);
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }


}