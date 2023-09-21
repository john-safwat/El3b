import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGamesForWishListUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Favorite/FavoriteTabNavigator.dart';
import 'package:flutter/material.dart';
import 'package:icons_launcher/cli_commands.dart';

class FavoriteTabViewModel extends BaseViewModel <FavoriteTabNavigator> {

  GetGamesForWishListUseCase getGamesForWishListUseCase ;
  DeleteGameFromWishListUseCase deleteGameFromWishListUseCase;
  FavoriteTabViewModel({
    required this.getGamesForWishListUseCase ,
    required this.deleteGameFromWishListUseCase
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
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // function to copy list to avoid any reference
  List<RAWGGame> copyList(List<RAWGGame> games){
    List<RAWGGame> copy = [];
    for(int i =0 ; i<games.length ;i++){
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
      query = query[0].toUpperCase() + query.substring(1);
      games = allGames.where((element) => element.name!.contains(query)).toList();
    }
    notifyListeners();
  }
}