import 'package:data/DataSource/feedback_remote_data_source_impl.dart';
import 'package:domain/DataSource/feedback_remote_data_source.dart';
import 'package:domain/Models/Feedback/feedback.dart';
import 'package:domain/Repository/feedback_repository.dart';


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