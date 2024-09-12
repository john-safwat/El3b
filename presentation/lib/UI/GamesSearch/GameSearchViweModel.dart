import 'package:core/Base/base_view_model.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/UseCase/add_game_to_history_use_case.dart';
import 'package:domain/UseCase/search_from_game_from_server_use_case.dart';
import 'package:presentation/UI/GamesSearch/GameSearchNavigator.dart';
import 'package:flutter/material.dart';

class GameSearchViewModel extends BaseViewModel<GameSearchNavigator> {

  SearchFromGameFromServerUseCase searchFromGameFromServerUseCase ;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  GameSearchViewModel({
    required this.searchFromGameFromServerUseCase ,
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


  // function to add game to history
  void addGameToHistory(RAWGGame game)async{
    try{
      await addGameToHistoryUseCase.invoke(game: game, uid: appConfigProvider!.getUser()!.uid);
    }catch(e){
      debugPrint(e.toString());
    }
  }


}