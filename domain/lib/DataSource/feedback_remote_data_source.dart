import 'package:data/Models/Feedback/feedback_dto.dart';

abstract class FeedbackRemoteDataSource {

  Future<String> sendFeedback({required FeedbackDTO feedback});

}