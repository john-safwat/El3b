import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGamesByGenreUseCase.dart';
import 'package:El3b/Presentation/UI/GamesList/GamesListNavigator.dart';
import 'package:flutter/material.dart';

class GamesListViewModel extends BaseViewModel<GamesListNavigator> {

  GetGamesByGenreUseCase getGamesByGenreUseCase;
  AddGameToWishListUseCase addGameToWishListUseCase;
  DeleteGameFromWishListUseCase deleteGameFromWishListUseCase;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  GamesListViewModel({
    required this.getGamesByGenreUseCase ,
    required this.addGameToWishListUseCase,
    required this.deleteGameFromWishListUseCase,
    required this.addGameToHistoryUseCase
  });

  num count = 0;
  int pageNumber = 1;

  String? errorMessage;
  List<RAWGGame> games = [];

  String genre = "";


  // function to get games by genre and page number
  void getGames()async{
    errorMessage = null;
    try{
      var (count , response) = await getGamesByGenreUseCase.invoke(
          genre: genre,
          pageNumber: pageNumber,
          uid: appConfigProvider!.getUser()!.uid
      );
      this.count = count??0;
      pageNumber++;
      for(int i = 0 ; i<response!.length ; i++){
        games.add(response[i]);
      }
      notifyListeners();
    }catch (e){
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



}