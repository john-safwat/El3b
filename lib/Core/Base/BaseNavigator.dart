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

}