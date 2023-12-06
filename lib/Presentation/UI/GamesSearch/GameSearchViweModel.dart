import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/SearchFromGameFromServerUseCase.dart';
import 'package:El3b/Presentation/UI/GamesSearch/GameSearchNavigator.dart';
import 'package:flutter/material.dart';

class GameSearchViewModel extends BaseViewModel<GameSearchNavigator> {

  SearchFromGameFromServerUseCase searchFromGameFromServerUseCase ;
  AddGameToWishListUseCase addGameToWishListUseCase;
  DeleteGameFromWishListUseCase deleteGameFromWishListUseCase;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  GameSearchViewModel({
    required this.searchFromGameFromServerUseCase ,
    required this.addGameToWishListUseCase,
    required this.deleteGameFromWishListUseCase,
    required this.addGameToHistoryUseCase
  });

  String? errorMessage;
  bool loading = false;
  List<RAWGGame> games = [];

  // function to go to home screen
  goToHome(){
    navigator!.goBack();
  }

  // function to search
  void search(String query)async{
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      if(query.length != 0){
        games = await searchFromGameFromServerUseCase.invoke(query: query, uid: appConfigProvider!.getUser()!.uid);
      }else {
        games= [];
      }
      loading = false ;
      notifyListeners();
    }catch(e){
      loading = false;
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