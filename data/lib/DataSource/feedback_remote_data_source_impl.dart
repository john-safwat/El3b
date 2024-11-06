import 'dart:async';

import 'package:core/Errors/firebase_fire_store_error_handler.dart';
import 'package:data/Firebase/feedback_firebase_database.dart';
import 'package:data/Models/Feedback/feedback_dto.dart';
import 'package:domain/DataSource/feedback_remote_data_source.dart';
import 'package:domain/Exception/firebase_user_database_exception.dart';
import 'package:domain/Exception/time_out_operations_exception.dart';
import 'package:domain/Exception/unknown_exception.dart';
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
