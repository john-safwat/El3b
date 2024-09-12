import 'dart:async';

import 'package:data/Firebase/firebase_images_database.dart';
import 'package:domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:domain/Exception/FirebaseImagesException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


// dependency injection
FirebaseImagesRemoteDatasource injectFirebaseImagesRemoteDatasource() {
  return FirebaseImagesRemoteDatasourceImpl(
      database: injectFirebaseImagesDatabase());
}

// the object
class FirebaseImagesRemoteDatasourceImpl
    implements FirebaseImagesRemoteDatasource {
  FirebaseImagesDatabase database;
  FirebaseImagesRemoteDatasourceImpl(
      {required this.database});


  // function to upload user image to firebase fireStore
  @override
  Future<String> uploadImage({required XFile file}) async {
    try {
      var response = await database
          .uploadImage(file: file)
          .timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseImagesException(errorMessage: e.code);
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "Uploading Image Timed Out Try Again");
    } catch (e) {
      throw UnknownException(errorMessage: "UnKnown Error");
    }
  }

  // function to upload user image to firebase fireStore
  @override
  Future<String> updateImage({required XFile file , required String url}) async {
    try {
      var response = await database
          .updateImage(file: file, url: url)
          .timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseImagesException(errorMessage: e.code);
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "Uploading Image Timed Out Try Again");
    } catch (e) {
      throw UnknownException(errorMessage: "UnKnown Error");
    }
  }
}
