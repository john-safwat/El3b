import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/SearchFromGameFromServerUseCase.dart';
import 'package:El3b/Presentation/UI/GamesSearch/GameSearchNavigator.dart';
import 'package:flutter/material.dart';

class GameSearchViewModel extends BaseViewModel<GameSearchNavigator> {

  SearchFromGameFromServerUseCase searchFromGameFromServerUseCase ;
  AddGameToWishListUseCase addGameToWishListUseCase;
  DeleteGameFromWishListUseCase deleteGameFromWishListUseCase;
  GameSearchViewModel({
    required this.searchFromGameFromServerUseCase ,
    required this.addGameToWishListUseCase,
    required this.deleteGameFromWishListUseCase
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
      if (e is DioServerException) {
        errorMessage = e.errorMessage;
      } else if (e is TimeOutOperationsException) {
        errorMessage = local!.operationTimedOut;
      } else if (e is InternetConnectionException) {
        errorMessage = local!.checkYourInternetConnection;
      } else if (e is UnknownException) {
        errorMessage = e.errorMessage;
      } else {
        errorMessage = e.toString();
      }
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

}