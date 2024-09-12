import 'package:data/Models/Feedback/FeedbackDTO.dart';

abstract class FeedbackRemoteDataSource {

  Future<String> sendFeedback({required FeedbackDTO feedback});

}