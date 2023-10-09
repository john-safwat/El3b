import 'package:El3b/Domain/Models/Feedback/Feedback.dart';

abstract class FeedbackRepository{

  Future<String> sendFeedback({required Feedback feedback});

}