import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/GatGamesFromHistoryUseCase.dart';
import 'package:El3b/Presentation/UI/History/HistoryNavigator.dart';
import 'package:flutter/material.dart';

class HistoryViewModel extends BaseViewModel<HistoryNavigator> {
  GatGamesFromHistoryUseCase gamesFromHistoryUseCase;
  AddGameToWishListUseCase addGameToWishListUseCase;
  DeleteGameFromWishListUseCase deleteGameFromWishListUseCase;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  HistoryViewModel({
    required this.gamesFromHistoryUseCase,
    required this.deleteGameFromWishListUseCase,
    required this.addGameToHistoryUseCase,
    required this.addGameToWishListUseCase,
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

  // function to add game to wishlist
  Future<void> editGameWishListState(RAWGGame game) async {
    try {
      if (!game.inWishList!) {
        game.inWishList = true;
        var response = await addGameToWishListUseCase.invoke(
            game: game, uid: appConfigProvider!.getUser()!.uid);
        if (response != 0) {
          navigator!.showSuccessNotification(message: local!.gameAddedToWishList);
        } else {
          navigator!.showErrorNotification(message: local!.someThingWentWrong);
        }
      } else {
        game.inWishList = false;
        var response = await deleteGameFromWishListUseCase.invoke(
            game: int.parse(game.id!.toString()),
            uid: appConfigProvider!.getUser()!.uid);
        if (response != 0) {
          navigator!
              .showSuccessNotification(message: local!.gameDeletedFromWishList);
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

}
