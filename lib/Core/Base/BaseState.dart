import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Core/Utils/DialogUtils.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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
  showFailMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction,}) {
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
  showLoading({required String message,}) {
    MyDialogUtils.showLoadingDialog(
      context: context,
      message: message,
      backgroundColor: viewModel!.themeProvider!.isDark()?MyTheme.purple : MyTheme.offWhite,
    );
  }

  @override
  showQuestionMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction,}) {
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
  showSuccessMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction,}) {
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

  @override
  showSuccessNotification({required String message}){
    ElegantNotification(
      icon:const Icon(Bootstrap.check , color: MyTheme.offWhite,),
      description: Text(message , style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.offWhite),),
      background: Colors.green,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: double.infinity,
      radius: 15,
      height: 50,
    ).show(context);
  }

  @override
  showErrorNotification({required String message}){
    ElegantNotification(
      icon:const Icon(Bootstrap.x_circle , color: MyTheme.offWhite,),
      description: Text(message , style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.offWhite),),
      background: Colors.red,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: double.infinity,
      radius: 15,
      height: 50,
    ).show(context);
  }

  @override
  showCustomNotification({
    required IconData iconData,
    required String message ,
    required Color background ,
    required double height
  }){
    ElegantNotification(
      icon:Icon(iconData , color: MyTheme.offWhite,),
      description: Text(message , style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.offWhite),),
      background: background,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: double.infinity,
      radius: 15,
      height: height,
    ).show(context);
  }


}
