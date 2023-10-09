import 'package:El3b/Data/Models/Feedback/FeedbackDTO.dart';

abstract class FeedbackRemoteDataSource {

  Future<String> sendFeedback({required FeedbackDTO feedback});

}