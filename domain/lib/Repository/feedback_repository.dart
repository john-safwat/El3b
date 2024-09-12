import 'package:domain/Models/Feedback/feedback.dart';

abstract class FeedbackRepository{

  Future<String> sendFeedback({required Feedback feedback});

}