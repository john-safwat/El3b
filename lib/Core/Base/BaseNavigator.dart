import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:flutter/material.dart';

abstract class BaseNavigator {
  showLoading({
    required String message
  });

  showFailMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction
  });

  showSuccessMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction
  });

  showQuestionMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction
  });

  goBack();
  goToSearchScreen();
  goToGameDetailsScreen(RAWGGame game);

  showErrorNotification({required String message});
  showSuccessNotification({required String message});
  showCustomNotification({
    required IconData iconData,
    required String message ,
    required Color background ,
    required double height
  });

  showMyModalBottomSheetWidget();

}