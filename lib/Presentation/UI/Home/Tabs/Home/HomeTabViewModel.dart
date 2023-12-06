
import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/URLLauncherException.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetFreeToPlayGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGiveawayGamesFromServerUseCase.dart';
import 'package:El3b/Domain/UseCase/GetRAWGGeneralGamesUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTabViewModel extends BaseViewModel <HomeTabNavigator> {

  GetAllGiveGamesUseCase getAllGiveGamesUseCase;

  GetFreeToPlayGamesUseCase getFreeToPlayGamesUseCase;
  GetRAWGGeneralGamesUseCase getRAWGGeneralGamesUseCase;
  AddGameToWishListUseCase addGameToWishListUseCase;
  DeleteGameFromWishListUseCase deleteGameFromWishListUseCase;
  GetGiveawayGamesFromServerUseCase gamesFromServerUseCase;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  HomeTabViewModel({
    required this.getAllGiveGamesUseCase,
    required this.getFreeToPlayGamesUseCase,
    required this.getRAWGGeneralGamesUseCase,
    required this.addGameToWishListUseCase,
    required this.deleteGameFromWishListUseCase,
    required this.gamesFromServerUseCase,
    required this.addGameToHistoryUseCase
  });

  // error message and list of games
  String? errorMessage;
  String? rawgErrorMessage;

  List<GiveawayGame> listGiveawayGames = [];
  List<FreeToPlayGame> listFreeToPLayGames = [];
  List<RAWGGame> listRAWGGames = [];

  // games selected flags
  bool giveawayGameSelected = false;
  late GiveawayGame giveawaySelectedGame;

  bool freeToPlayGameSelected = false;
  late FreeToPlayGame freeToPlayGameSelectedGame;

  // function to call games apis using use case
  void getGames() async {
    errorMessage = null;
    listGiveawayGames = [];
    listFreeToPLayGames = [];
    notifyListeners();
    try {
      listGiveawayGames = await getAllGiveGamesUseCase.invoke();
      listFreeToPLayGames = await getFreeToPlayGamesUseCase.invoke();
      notifyListeners();
    } catch (e) {
      errorMessage = handleExceptions(e as Exception);
    }
    notifyListeners();
  }

  void getGeneralGames()async{
    rawgErrorMessage = null;
    listRAWGGames = [];
    notifyListeners();
    try {
      listRAWGGames = await getRAWGGeneralGamesUseCase.invoke(uid: appConfigProvider!.getUser()!.uid);
      notifyListeners();
    } catch (e) {
      rawgErrorMessage = handleExceptions(e as Exception);
      notifyListeners();
    }
  }


  // openGameURL
  openURL(String url) async {
    // parse the url string to uri
    Uri uri = Uri.parse(url);
    try {
      // check if the uri can be launched then it will launch else it will throw and show notification
      if (await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
        navigator!.showSuccessNotification(message: local!.weHopeThatYouLoveIt);
      } else {
        throw URLLauncherException(errorMessage: local!.urlLaunchingError);
      }
    } catch (e) {
      navigator!.showErrorNotification(message: handleExceptions(e as Exception));
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

  // function to add game to history
  void addGameToHistory(RAWGGame game)async{
    try{
      await addGameToHistoryUseCase.invoke(game: game, uid: appConfigProvider!.getUser()!.uid);
    }catch(e){
      debugPrint(e.toString());
    }
  }


  // function to load data from server for new updates
  Future<void> loadNewGame()async {
    try{
      listGiveawayGames = await gamesFromServerUseCase.invoke();
      notifyListeners();
    }catch(e){
      debugPrint(e.toString());
    }
  }

  // change state functions
  // select game
  selectGiveawayGame(GiveawayGame game) {
    giveawayGameSelected = true;
    giveawaySelectedGame = game;
    notifyListeners();
  }

  // unselect game
  unselectGiveawayGame() {
    giveawayGameSelected = false;
    notifyListeners();
  }

  // select game
  selectFreeToPlayGame(FreeToPlayGame game) {
    freeToPlayGameSelected = true;
    freeToPlayGameSelectedGame = game;
    notifyListeners();
  }

  // unselect game
  unselectFreeToPlayGame() {
    freeToPlayGameSelected = false;
    notifyListeners();
  }




}