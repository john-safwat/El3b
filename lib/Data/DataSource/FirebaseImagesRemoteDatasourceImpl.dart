import 'dart:async';

import 'package:El3b/Data/Error%20Handler/ErrorHandler.dart';
import 'package:El3b/Data/Firebase/FirebaseImagesDatabase.dart';
import 'package:El3b/Domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:El3b/Domain/Exception/FirebaseImagesException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


// dependency injection
FirebaseImagesRemoteDatasource getFirebaseImagesRemoteDatasource() {
  return FirebaseImagesRemoteDatasourceImpl(
      database: injectFirebaseImagesDatabase(), errorHandler: injectErrorHandler());
}

// the object
class FirebaseImagesRemoteDatasourceImpl
    implements FirebaseImagesRemoteDatasource {
  FirebaseImagesDatabase database;
  ErrorHandler errorHandler;
  FirebaseImagesRemoteDatasourceImpl(
      {required this.database, required this.errorHandler});

  @override
  Future<String> uploadUserProfileImage({required XFile file}) async {
    try {
      var response = await database
          .uploadImage(file: file)
          .timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseImagesException(
          errorMessage: errorHandler.handleFirebaseImageDatabaseExceptions(
              error: e.code));
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(
          errorMessage: "Uploading Image Timed Out Try Again");
    } catch (e) {
      throw UnknownException(errorMessage: "UnKnown Error");
    }
  }
}
