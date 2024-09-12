import 'package:core/Base/base_navigator.dart';
import 'package:core/Base/base_view_model.dart';
import 'package:core/Errors/dio_error_handler.dart';
import 'package:core/Errors/firebase_auth_exception_handler.dart';
import 'package:core/Errors/firebase_fire_store_error_handler.dart';
import 'package:core/Errors/firebase_image_database_exceptions_handler.dart';
import 'package:core/Errors/firebase_login_error_handler.dart';
import 'package:core/Providers/app_config_provider.dart';
import 'package:core/Providers/local_provider.dart';
import 'package:core/Providers/theme_provider.dart';
import 'package:core/Theme/theme.dart';
import 'package:core/Utils/dialog_utils.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:presentation/UI/GameDetails/GameDetailsView.dart';
import 'package:presentation/UI/GamesSearch/GameSearchView.dart';
import 'package:presentation/UI/Widgets/BottomSheetImagePicker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


abstract class BaseState< T extends StatefulWidget , VM extends BaseViewModel> extends State<T> implements BaseNavigator{
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
    viewModel.appConfigProvider = Provider.of<AppConfigProvider>(context , listen: false);
    viewModel.dioErrorHandler = injectDioErrorHandler();
    viewModel.firebaseLoginErrorHandler = injectFirebaseLoginErrorHandler();
    viewModel.firebaseImageDatabaseExceptionsHandler = injectFirebaseImageDatabaseExceptionsHandler();
    viewModel.firebaseFireStoreErrorHandler = injectFirebaseFireStoreErrorHandler();
    viewModel.firebaseAuthExceptionHandler = injectFirebaseAuthExceptionHandler();
    viewModel.addGameToWishListUseCase = injectAddGameToWishListUseCase();
    viewModel.deleteGameFromWishListUseCase = injectDeleteGameFromWishListUseCase();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.navigator = null ;
    viewModel.appConfigProvider = null;
    viewModel.themeProvider = null ;
    viewModel.localProvider =null;
  }

  VM initViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.themeProvider = Provider.of<ThemeProvider>(context);
    viewModel.localProvider = Provider.of<LocalProvider>(context);
    viewModel.local = AppLocalizations.of(context)!;
    viewModel.mediaQuery = MediaQuery.of(context).size;
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
    );
  }

  @override
  showQuestionMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction,}) {
    MyDialogUtils.showQuestionMessage(
      context: context,
      message: message,
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
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showSuccessNotification({required String message}){
    ElegantNotification(
      icon:const Icon(EvaIcons.checkmark , color: MyTheme.offWhite,),
      description: Text(message , style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.offWhite),),
      background: Colors.green,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: viewModel.mediaQuery!.width,
      borderRadius: BorderRadius.circular(15),
      height: 50,
    ).show(context);
  }

  @override
  showErrorNotification({required String message}){
    ElegantNotification(
      icon:const Icon(EvaIcons.close , color: MyTheme.offWhite,),
      description: Text(message , style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.offWhite),),
      background: Colors.red,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: viewModel.mediaQuery!.width,
      borderRadius: BorderRadius.circular(15),
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
      width: viewModel.mediaQuery!.width,
      borderRadius: BorderRadius.circular(15),
      height: height,
    ).show(context);
  }

  @override
  goToSearchScreen() {
    Navigator.of(context).push(PageAnimationTransition(page: const GameSearchView(), pageAnimationType: BottomToTopTransition()));
  }

  @override
  goToGameDetailsScreen(RAWGGame game) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsView(game: game)));
  }


  @override
  showMyModalBottomSheetWidget() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => MyBottomSheetWidget(
          title: viewModel.local!.selectPickingImageMethod,
          pickImageFromCamera: viewModel.pickImageFromCamera,
          cameraTitle: viewModel.local!.camera,
          galleryTitle: viewModel.local!.gallery,
          pickImageFromGallery: viewModel.pickImageFromGallery,
        ),
        backgroundColor: viewModel.themeProvider!.isDark()
            ? MyTheme.purple
            : MyTheme.offWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )));
  }

}
