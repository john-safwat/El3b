import 'package:data/Repository/feedback_repository_impl.dart';
import 'package:domain/Models/Feedback/feedback.dart';
import 'package:domain/Repository/feedback_repository.dart';


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