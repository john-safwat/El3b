import 'package:El3b/Data/DataSource/FeedbackRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/FeedbackRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Feedback/Feedback.dart';
import 'package:El3b/Domain/Repository/FeedbackRepository.dart';


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