import 'package:flutter/material.dart';

abstract class BaseNavigator {
  showLoading({
    required BuildContext context,
    required String message,
    required Color backgroundColor
  });

  showFailMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  });

  showSuccessMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  });

  showQuestionMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  });

  goBack();

}