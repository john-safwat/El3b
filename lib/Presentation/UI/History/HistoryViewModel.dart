import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:El3b/Domain/UseCase/GatGamesFromHistoryUseCase.dart';
import 'package:El3b/Presentation/UI/History/HistoryNavigator.dart';
import 'package:flutter/material.dart';

class HistoryViewModel extends BaseViewModel<HistoryNavigator> {
  GatGamesFromHistoryUseCase gamesFromHistoryUseCase;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  HistoryViewModel({
    required this.gamesFromHistoryUseCase,
    required this.addGameToHistoryUseCase
  });

  String? errorMessage;
  List<RAWGGame> games = [];

  // function to load data from local database
  void loadData() async {
    errorMessage = null;
    try {
      games = await gamesFromHistoryUseCase.invoke(
          uid: appConfigProvider!.getUser()!.uid);
      notifyListeners();
    } catch (e) {
      errorMessage = handleExceptions(e as Exception);
      notifyListeners();
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

}
