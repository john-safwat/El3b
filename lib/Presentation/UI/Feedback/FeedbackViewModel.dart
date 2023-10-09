import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Feedback/Feedback.dart';
import 'package:El3b/Domain/UseCase/SendFeedbackUseCase.dart';
import 'package:El3b/Presentation/UI/Feedback/FeedbackNavigator.dart';
import 'package:flutter/cupertino.dart';

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
      if (e is FirebaseUserAuthException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else if (e is TimeOutOperationsException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else if (e is UnknownException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else if (e is FirebaseUserDatabaseException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else {
        navigator!.showFailMessage(
          message: e.toString(),
          posActionTitle: local!.tryAgain,
        );
      }
    }

  }

}