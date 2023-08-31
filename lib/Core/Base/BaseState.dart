import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


abstract class BaseState< T extends StatefulWidget , VM extends BaseViewModel> extends State<T> implements BaseNavigator{
  VM? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel!.navigator = this;
    viewModel!.appConfigProvider = Provider.of<AppConfigProvider>(context , listen: false);
    viewModel!.themeProvider = Provider.of<ThemeProvider>(context , listen: false);
    viewModel!.localProvider = Provider.of<LocalProvider>(context , listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel!.navigator = null ;
    viewModel!.appConfigProvider = null;
    viewModel!.themeProvider = null ;
    viewModel!.localProvider =null;
    viewModel =null;
  }

  VM initViewModel();

  @override
  goBack() {
    Navigator.pop(context);
  }

  @override
  showFailMessage({required BuildContext context, required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction, required Color backgroundColor}) {
    MyDialogUtils.showFailMessage(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showLoading({required BuildContext context, required String message, required Color backgroundColor}) {
    MyDialogUtils.showLoadingDialog(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
    );
  }

  @override
  showQuestionMessage({required BuildContext context, required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction, required Color backgroundColor}) {
    MyDialogUtils.showQuestionMessage(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showSuccessMessage({required BuildContext context, required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction, required Color backgroundColor}) {
    MyDialogUtils.showSuccessMessage(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }


}
