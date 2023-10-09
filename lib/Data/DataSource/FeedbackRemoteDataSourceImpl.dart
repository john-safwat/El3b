import 'dart:async';

import 'package:El3b/Data/Error/FirebaseErrorHandler.dart';
import 'package:El3b/Data/Firebase/FeedbackFirebaseDatabase.dart';
import 'package:El3b/Data/Models/Feedback/FeedbackDTO.dart';
import 'package:El3b/Domain/DataSource/FeedbackRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:firebase_auth/firebase_auth.dart';

// dependency injection
FeedbackRemoteDataSource injectFeedbackRemoteDataSource() {
  return FeedbackRemoteDataSourceImpl(
      firebaseDatabase: injectFeedbackFirebaseDatabase(),
      errorHandler: injectFirebaseErrorHandler());
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {

  FeedbackFirebaseDatabase firebaseDatabase;
  FirebaseErrorHandler errorHandler;
  FeedbackRemoteDataSourceImpl({required this.firebaseDatabase, required this.errorHandler});

  // function to add feedback to database
  @override
  Future<String> sendFeedback({required FeedbackDTO feedback}) async {
    try {
      var response = await firebaseDatabase.addFeedback(feedback: feedback).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseAuthException catch (e) {
      throw FirebaseUserAuthException(errorMessage: errorHandler.handleFirebaseAuthException(error: e.code));
    } on FirebaseException catch (e) {
      throw FirebaseUserDatabaseException(errorMessage: errorHandler.handleFirebaseFireStoreError(e.code));
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }
  
}
