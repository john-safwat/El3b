import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Achievements/Achievement.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:El3b/Domain/Models/Games/GameDetails/GameDetails.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/GetGameAchievementsUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGameDetailsUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGameDevelopersUseCase.dart';
import 'package:El3b/Presentation/UI/GameDetails/GameDetailsNavigator.dart';
import 'package:flutter/material.dart';


class GameDetailsViewModel extends BaseViewModel<GameDetailsNavigator> {


  RAWGGame game;
  GetGameDetailsUseCase getGameDetailsUseCase;
  GetGameDevelopersUseCase getGameDevelopersUseCase;
  GetGameAchievementsUseCase getGameAchievementsUseCase;
  GameDetailsViewModel({required this.game , required this.getGameDetailsUseCase , required this.getGameDevelopersUseCase , required this.getGameAchievementsUseCase});

  GameDetails? gameDetails;
  String? gameErrorMessage ;

  List<Developer> gameDevelopers = [];
  bool gameDevelopersLoaded = false;
  String? developersErrorMessage ;

  List<Achievement> gameAchievements = [];
  bool gameAchievementsLoaded = false ;
  String? achievementsErrorMessage ;

  // function to get the game details
  void getGameDetails()async{
    gameDetails = null ;
    gameErrorMessage = null;
    notifyListeners();
    try {
      gameDetails = await getGameDetailsUseCase.invoke(id: game.id.toString());
      notifyListeners();
      getGameDevelopers(id: gameDetails!.id.toString());
      getGameAchievements(id: gameDetails!.id.toString());
    } catch (e) {
      if (e is DioServerException) {
        gameErrorMessage = e.errorMessage;
      } else if (e is TimeOutOperationsException) {
        gameErrorMessage = local!.operationTimedOut;
      } else if (e is InternetConnectionException) {
        gameErrorMessage = local!.checkYourInternetConnection;
      } else if (e is UnknownException) {
        gameErrorMessage = e.errorMessage;
      } else {
        gameErrorMessage = e.toString();
      }
      notifyListeners();
    }
  }

  // function to load all game developers
  void getGameDevelopers({required String id})async{
    developersErrorMessage = null;
    gameDevelopers = [];
    notifyListeners();
    try {
      gameDevelopers = await getGameDevelopersUseCase.invoke(id: game.id.toString());
      gameDevelopersLoaded = true;
      notifyListeners();
    } catch (e) {
      if (e is DioServerException) {
        developersErrorMessage = e.errorMessage;
      } else if (e is TimeOutOperationsException) {
        developersErrorMessage = local!.operationTimedOut;
      } else if (e is InternetConnectionException) {
        developersErrorMessage = local!.checkYourInternetConnection;
      } else if (e is UnknownException) {
        developersErrorMessage = e.errorMessage;
      } else {
        developersErrorMessage = e.toString();
      }
      notifyListeners();
    }
  }

  // function to load all game developers
  void getGameAchievements({required String id})async{
    achievementsErrorMessage = null;
    gameAchievements = [];
    notifyListeners();
    try {
      gameAchievements = await getGameAchievementsUseCase.invoke(id: game.id.toString());
      gameAchievementsLoaded = true;
      notifyListeners();
    } catch (e) {
      if (e is DioServerException) {
        achievementsErrorMessage = e.errorMessage;
      } else if (e is TimeOutOperationsException) {
        achievementsErrorMessage = local!.operationTimedOut;
      } else if (e is InternetConnectionException) {
        achievementsErrorMessage = local!.checkYourInternetConnection;
      } else if (e is UnknownException) {
        achievementsErrorMessage = e.errorMessage;
      } else {
        achievementsErrorMessage = e.toString();
      }
      notifyListeners();
    }
  }

  // function to calc the total ratings of the game
  double calcGameRatingsCount(){
    double count = 0;
    for(int i =0 ; i<gameDetails!.ratings!.length;i++){
      count += gameDetails!.ratings![i].count??0;
    }
    return count;
  }

  // function to calc the steps of the gradiant based on the rating count
  List<double> calcStepsList(){

    double count = calcGameRatingsCount();
    double sum = 0 ;
    List<double> steps = [];

    for(int i = 0; i<gameDetails!.ratings!.length ; i++){
      steps.add(sum);
      sum += (gameDetails!.ratings![i].count! / count);
      steps.add(sum);
    }
    return steps;
  }

  List<Color> getColorsList(){
    List<Color> colors = [];
    for(int i = 0; i<gameDetails!.ratings!.length ; i++){
      if (gameDetails!.ratings![i].id == 5){
        colors.add(const Color(0xFF85CC36));
        colors.add(const Color(0xFF85CC36));
      }else if (gameDetails!.ratings![i].id == 4){
        colors.add(const Color(0xFF4E6DD1));
        colors.add(const Color(0xFF4E6DD1));
      }else if (gameDetails!.ratings![i].id == 3){
        colors.add(const Color(0xFFF9A541));
        colors.add(const Color(0xFFF9A541));
      }else{
        colors.add(const Color(0xFFF73645));
        colors.add(const Color(0xFFF73645));
      }
    }
    return colors;
  }

  // function to return list of rating color meaning
  List<String> getRatingMeaning(){
    return [
      local!.exceptional,
      local!.recommended,
      local!.meh ,
      local!.skip ,
    ];
  }

  // function to navigate to game developer profile
  goToGameDeveloperProfile(Developer developer){
    navigator!.goToDeveloperProfileScreen(developer: developer);
  }

  // function to navigate to the game achievements list
  goToAchievementsListScreen(){
    navigator!.goToAchievementsListScreen(gameId: game.id.toString());
  }


}