import 'package:flutter/material.dart';

abstract class BaseNavigator {
  showLoading({
    required String message,
    required Color backgroundColor
  });

  showFailMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  });

  showSuccessMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  });

  showQuestionMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  });

  goBack();

}