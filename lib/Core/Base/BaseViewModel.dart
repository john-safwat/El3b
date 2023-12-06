import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Core/Errors/DioErrorHandler.dart';
import 'package:El3b/Core/Errors/FirebaseAuthExceptionHandler.dart';
import 'package:El3b/Core/Errors/FirebaseFireStoreErrorHandler.dart';
import 'package:El3b/Core/Errors/FirebaseImageDatabaseExceptionsHandler.dart';
import 'package:El3b/Core/Errors/FirebaseLoginErrorHandler.dart';
import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Domain/Exception/CacheException.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/FirebaseImagesException.dart';
import 'package:El3b/Domain/Exception/FirebaseLoginException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/PermissionDeniedException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/URLLauncherException.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
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

}
