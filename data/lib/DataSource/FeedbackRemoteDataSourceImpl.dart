import 'dart:async';

import 'package:core/Errors/FirebaseFireStoreErrorHandler.dart';
import 'package:data/Firebase/FeedbackFirebaseDatabase.dart';
import 'package:data/Models/Feedback/FeedbackDTO.dart';
import 'package:domain/DataSource/FeedbackRemoteDataSource.dart';
import 'package:domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dependency injection
FeedbackRemoteDataSource injectFeedbackRemoteDataSource() {
  return FeedbackRemoteDataSourceImpl(
    firebaseDatabase: injectFeedbackFirebaseDatabase()
  );
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {

  FeedbackFirebaseDatabase firebaseDatabase;
  FeedbackRemoteDataSourceImpl({required this.firebaseDatabase});

  // function to add feedback to database
  @override
  Future<String> sendFeedback({required FeedbackDTO feedback}) async {
    try {
      var response = await firebaseDatabase.addFeedback(feedback: feedback).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseFireStoreDatabaseException(errorMessage: e.code);
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }
  
}
