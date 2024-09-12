
import 'package:core/Base/base_view_model.dart';
import 'package:domain/Exception/url_launcher_exception.dart';
import 'package:domain/Models/Games/FreeToPlayGame/free_to_play_game.dart';
import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/UseCase/add_game_to_history_use_case.dart';
import 'package:domain/UseCase/get_all_give_games_use_case.dart';
import 'package:domain/UseCase/get_free_to_play_games_use_case.dart';
import 'package:domain/UseCase/get_giveaway_games_from_server_use_case.dart';
import 'package:domain/UseCase/get_rawg_general_games_use_case.dart';
import 'package:presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTabViewModel extends BaseViewModel <HomeTabNavigator> {

  GetAllGiveGamesUseCase getAllGiveGamesUseCase;

  GetFreeToPlayGamesUseCase getFreeToPlayGamesUseCase;
  GetRAWGGeneralGamesUseCase getRAWGGeneralGamesUseCase;
  GetGiveawayGamesFromServerUseCase gamesFromServerUseCase;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  HomeTabViewModel({
    required this.getAllGiveGamesUseCase,
    required this.getFreeToPlayGamesUseCase,
    required this.getRAWGGeneralGamesUseCase,
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
  Future<void> getGames() async {
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

  Future<void> getGeneralGames()async{
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