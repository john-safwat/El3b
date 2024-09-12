import 'package:core/Base/BaseViewModel.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:domain/UseCase/GetGamesByGenreUseCase.dart';
import 'package:presentation/UI/GamesList/GamesListNavigator.dart';
import 'package:flutter/material.dart';

class GamesListViewModel extends BaseViewModel<GamesListNavigator> {

  GetGamesByGenreUseCase getGamesByGenreUseCase;
  AddGameToHistoryUseCase addGameToHistoryUseCase;
  GamesListViewModel({
    required this.getGamesByGenreUseCase ,
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

  // function to add game to history
  void addGameToHistory(RAWGGame game)async{
    try{
      await addGameToHistoryUseCase.invoke(game: game, uid: appConfigProvider!.getUser()!.uid);
    }catch(e){
      debugPrint(e.toString());
    }
  }



}