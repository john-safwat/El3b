import 'package:core/Base/BaseViewModel.dart';
import 'package:domain/Models/Feedback/Feedback.dart';
import 'package:domain/UseCase/SendFeedbackUseCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:presentation/UI/Feedback/FeedbackNavigator.dart';

class FeedbackViewModel extends BaseViewModel<FeedbackNavigator>{


  SendFeedbackUseCase useCase;
  FeedbackViewModel({required this.useCase});

  double rating = 0;
  TextEditingController controller = TextEditingController();

  // function to update rating
  void changeRating(double newRating){
    rating = newRating;
    notifyListeners();
  }

  // function to validate on data
  String? feedbackValidation(String value) {
    return null;
  }

  // function to send the user feedback
  void sendFeedback()async{

    navigator!.showLoading(message: local!.loading);
    try{
      var response = await useCase.invoke(
          feedback: Feedback(
              uid: appConfigProvider!.getUser()!.uid,
              message: controller.text,
              rating: rating,
              userName: appConfigProvider!.getUser()!.displayName??"No Name",
              userEmail: appConfigProvider!.getUser()!.email??"No Email",
              image: appConfigProvider!.getUser()!.photoURL??"No Photo"
          )
      );
      navigator!.goBack();
      navigator!.showSuccessMessage(message: response, posActionTitle: local!.ok );
    }catch (e){
      navigator!.goBack();
      navigator!.showFailMessage(
        message: handleExceptions(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }

  }

}