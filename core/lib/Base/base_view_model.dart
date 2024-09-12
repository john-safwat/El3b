import 'package:core/Base/base_navigator.dart';
import 'package:core/Constants/constants.dart';
import 'package:core/Errors/dio_error_handler.dart';
import 'package:core/Errors/firebase_auth_exception_handler.dart';
import 'package:core/Errors/firebase_fire_store_error_handler.dart';
import 'package:core/Errors/firebase_image_database_exceptions_handler.dart';
import 'package:core/Errors/firebase_login_error_handler.dart';
import 'package:core/Providers/app_config_provider.dart';
import 'package:core/Providers/local_provider.dart';
import 'package:core/Providers/theme_provider.dart';
import 'package:domain/Exception/cache_exception.dart';
import 'package:domain/Exception/dio_server_exception.dart';
import 'package:domain/Exception/firebase_images_exception.dart';
import 'package:domain/Exception/firebase_login_exception.dart';
import 'package:domain/Exception/firebase_user_auth_exception.dart';
import 'package:domain/Exception/firebase_user_database_exception.dart';
import 'package:domain/Exception/internet_connection_exception.dart';
import 'package:domain/Exception/permission_denied_exception.dart';
import 'package:domain/Exception/time_out_operations_exception.dart';
import 'package:domain/Exception/url_launcher_exception.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/UseCase/add_game_to_wish_list_use_case.dart';
import 'package:domain/UseCase/delete_game_from_wish_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;

  ThemeProvider? themeProvider;
  LocalProvider? localProvider;
  AppConfigProvider? appConfigProvider;
  AppLocalizations? local;
  Size? mediaQuery;
  Constants constants = Constants.getInstance();
  late AddGameToWishListUseCase addGameToWishListUseCase;
  late DeleteGameFromWishListUseCase deleteGameFromWishListUseCase;

  // error handlers
  late DioErrorHandler dioErrorHandler;
  late FirebaseAuthExceptionHandler firebaseAuthExceptionHandler;
  late FirebaseFireStoreErrorHandler firebaseFireStoreErrorHandler;
  late FirebaseImageDatabaseExceptionsHandler
      firebaseImageDatabaseExceptionsHandler;
  late FirebaseLoginErrorHandler firebaseLoginErrorHandler;

  XFile? image;

  bool rawgGameSelected = false;
  late RAWGGame rawgGameSelectedGame;

  // select game
  selectRAWGGame(RAWGGame game) {
    rawgGameSelected = true;
    rawgGameSelectedGame = game;
    notifyListeners();
  }

  // unselect game
  unselectRAWGGame() {
    rawgGameSelected = false;
    notifyListeners();
  }

  // function to navigate to the search screen
  goToSearchScreen() {
    navigator!.goToSearchScreen();
  }

  // function to go to game details screen
  goToGameDetailsScreen(RAWGGame game) {
    navigator!.goToGameDetailsScreen(game);
  }

  // image picker from camera
  Future<void> pickImageFromCamera() async {
    navigator!.goBack();
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  // image picker from gallery
  Future<void> pickImageFromGallery() async {
    navigator!.goBack();
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  // function to show modal Bottom Sheet
  void showMyModalBottomSheet() {
    navigator!.showMyModalBottomSheetWidget();
  }

  String handleExceptions(Exception e) {
    if (e is CacheException) {
      return local!.unableToLoadDate;
    } else if (e is DioServerException) {
      return localProvider!.isEn()
          ? dioErrorHandler.dioExceptionHandlerEnglish(e.errorMessage)
          : dioErrorHandler.dioExceptionHandlerArabic(e.errorMessage);
    } else if (e is FirebaseImagesException) {
      return localProvider!.isEn()
          ? firebaseImageDatabaseExceptionsHandler
              .handleFirebaseImageDatabaseExceptionsEnglish(
                  error: e.errorMessage)
          : firebaseImageDatabaseExceptionsHandler
              .handleFirebaseImageDatabaseExceptionsArabic(
                  error: e.errorMessage);
    } else if (e is FirebaseLoginException) {
      return localProvider!.isEn()
          ? firebaseLoginErrorHandler.handleLoginErrorEnglish(e.errorMessage)
          : firebaseLoginErrorHandler.handleLoginErrorArabic(e.errorMessage);
    } else if (e is FirebaseUserAuthException) {
      return localProvider!.isEn()
          ? firebaseAuthExceptionHandler.handleFirebaseAuthExceptionEnglish(
              error: e.errorMessage)
          : firebaseAuthExceptionHandler.handleFirebaseAuthExceptionArabic(
              error: e.errorMessage);
    } else if (e is FirebaseFireStoreDatabaseException) {
      return localProvider!.isEn()
          ? firebaseFireStoreErrorHandler
              .handleFirebaseFireStoreErrorEnglish(e.errorMessage)
          : firebaseFireStoreErrorHandler
              .handleFirebaseFireStoreErrorArabic(e.errorMessage);
    } else if (e is InternetConnectionException) {
      return local!.checkYourInternetConnection;
    }else if (e is PermissionDeniedException){
      return local!.permissionDenied;
    }else if (e is TimeOutOperationsException){
      return local!.operationTimedOut;
    }else if (e is URLLauncherException){
      return local!.urlLaunchingError;
    }else {
      return local!.someThingWentWrong;
    }
  }

  // function to add game to wishlist
  Future<void> editGameWishListState(RAWGGame game) async {
    try {
      if (!game.inWishList!) {
        game.inWishList = true;
        var response = await addGameToWishListUseCase.invoke(
            game: game, uid: appConfigProvider!.getUser()!.uid);
        if (response != 0) {
          navigator!.showSuccessNotification(
              message: local!.gameAddedToWishList);
        } else {
          navigator!.showErrorNotification(message: local!.someThingWentWrong);
        }
      } else {
        game.inWishList = false;
        var response = await deleteGameFromWishListUseCase.invoke(
            game: int.parse(game.id!.toString()),
            uid: appConfigProvider!.getUser()!.uid);
        if (response != 0) {
          navigator!.showSuccessNotification(
              message: local!.gameDeletedFromWishList);
        } else {
          navigator!.showErrorNotification(message: local!.someThingWentWrong);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

}
