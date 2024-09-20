import 'package:domain/Models/Feedback/user_feedback.dart';

abstract class FeedbackRepository{

  Future<String> sendFeedback({required UserFeedback feedback});

}