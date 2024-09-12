import 'package:core/Base/base_view_model.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:domain/UseCase/GetGamesForWishListUseCase.dart';
import 'package:presentation/UI/Home/Tabs/Favorite/FavoriteTabNavigator.dart';
import 'package:flutter/material.dart';

class FavoriteTabViewModel extends BaseViewModel <FavoriteTabNavigator> {

  GetGamesForWishListUseCase getGamesForWishListUseCase ;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  FavoriteTabViewModel({
    required this.getGamesForWishListUseCase ,
    required this.addGameToHistoryUseCase
  });


  String? errorMessage;
  List<RAWGGame> allGames= [];
  List<RAWGGame> games= [];

  // function to load data from
  void loadData()async{
    errorMessage = null;
    allGames = [];
    games = [];
    notifyListeners();
    try{
      allGames = await getGamesForWishListUseCase.invoke(uid: appConfigProvider!.getUser()!.uid);
      games = copyList(allGames);
      notifyListeners();
    }catch(e){
      errorMessage = handleExceptions(e as Exception);
      notifyListeners();
    }
  }

  // function to copy list to avoid any reference
  List<RAWGGame> copyList(List<RAWGGame> games){
    List<RAWGGame> copy = [];
    for(int i = 0 ; i<games.length ;i++){
      copy.add(games[i]);
    }
    return copy;
  }


  // function to delete game from wish list
  deleteGame(RAWGGame game) async{
    try{
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
      allGames.removeWhere((element) => element.id == game.id);
      games = copyList(allGames);
      notifyListeners();
    }catch (e){
      debugPrint(e.toString());
    }
  }

  // function to search for games in the list of games
  search(String query) {
    games = allGames.where((element) => element.name!.contains(query)).toList();
    if (games.isEmpty){
      games = allGames.where((element) => element.name!.toLowerCase().contains(query.toLowerCase())).toList();
    }
    if (games.isEmpty) {
      games = allGames.where((element) => element.name!.toUpperCase().contains(query.toUpperCase())).toList();
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