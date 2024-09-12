import 'package:data/DataSource/feedback_remote_data_source_impl.dart';
import 'package:domain/DataSource/FeedbackRemoteDataSource.dart';
import 'package:domain/Models/Feedback/Feedback.dart';
import 'package:domain/Repository/FeedbackRepository.dart';


// dependency injection
FeedbackRepository injectFeedbackRepository(){
  return FeedbackRepositoryImpl(remoteDataSource: injectFeedbackRemoteDataSource());
}

class FeedbackRepositoryImpl implements FeedbackRepository{

  FeedbackRemoteDataSource remoteDataSource;
  FeedbackRepositoryImpl ({required this.remoteDataSource});

  @override
  Future<String> sendFeedback({required Feedback feedback}) async{
    var response = await remoteDataSource.sendFeedback(feedback: feedback.toDatasource());
    return response;
  }

}