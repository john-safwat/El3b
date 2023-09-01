import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
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
  Widget build(BuildContext context) {
    viewModel!.themeProvider = Provider.of<ThemeProvider>(context);
    viewModel!.localProvider = Provider.of<LocalProvider>(context);
    viewModel!.local = AppLocalizations.of(context)!;
    return const SizedBox();
  }


  @override
  goBack() {
    Navigator.pop(context);
  }

  @override
  showFailMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction, required Color backgroundColor}) {
    MyDialogUtils.showFailMessage(
      context: context,
      message: message,
      backgroundColor: viewModel!.themeProvider!.isDark()?MyTheme.purple : MyTheme.offWhite,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showLoading({required String message, required Color backgroundColor}) {
    MyDialogUtils.showLoadingDialog(
      context: context,
      message: message,
      backgroundColor: viewModel!.themeProvider!.isDark()?MyTheme.purple : MyTheme.offWhite,
    );
  }

  @override
  showQuestionMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction, required Color backgroundColor}) {
    MyDialogUtils.showQuestionMessage(
      context: context,
      message: message,
      backgroundColor: viewModel!.themeProvider!.isDark()?MyTheme.purple : MyTheme.offWhite,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showSuccessMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction, required Color backgroundColor}) {
    MyDialogUtils.showSuccessMessage(
      context: context,
      message: message,
      backgroundColor: viewModel!.themeProvider!.isDark()?MyTheme.purple : MyTheme.offWhite,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }



}
