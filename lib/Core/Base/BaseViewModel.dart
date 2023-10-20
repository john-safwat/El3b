import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';


class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {

  N? navigator;

  ThemeProvider? themeProvider;
  LocalProvider? localProvider;
  AppConfigProvider? appConfigProvider ;
  AppLocalizations? local ;
  Size? mediaQuery;

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
  goToSearchScreen(){
    navigator!.goToSearchScreen();
  }

  // function to go to game details screen
  goToGameDetailsScreen(RAWGGame game){
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


}