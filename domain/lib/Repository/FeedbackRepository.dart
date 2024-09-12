import 'package:domain/Models/Feedback/Feedback.dart';

abstract class FeedbackRepository{

  Future<String> sendFeedback({required Feedback feedback});

}