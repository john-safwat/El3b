import 'package:El3b/Data/Repository/FeedbackRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Feedback/Feedback.dart';
import 'package:El3b/Domain/Repository/FeedbackRepository.dart';


// dependency injection
SendFeedbackUseCase injectSendFeedbackUseCase(){
  return SendFeedbackUseCase(repository: injectFeedbackRepository());
}

class SendFeedbackUseCase {

  FeedbackRepository repository;
  SendFeedbackUseCase({required this.repository});

  Future<String> invoke({required Feedback feedback})async{
    var response = await repository.sendFeedback(feedback: feedback);
    return response;
  }

}