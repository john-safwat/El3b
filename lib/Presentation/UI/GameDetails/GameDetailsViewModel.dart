import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:El3b/Domain/Models/Games/GameDetails/GameDetails.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/GetGameDetailsUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGameDevelopersUseCase.dart';
import 'package:El3b/Presentation/UI/GameDetails/GameDetailsNavigator.dart';


class GameDetailsViewModel extends BaseViewModel<GameDetailsNavigator> {


  RAWGGame game;
  GetGameDetailsUseCase getGameDetailsUseCase;
  GetGameDevelopersUseCase getGameDevelopersUseCase;
  GameDetailsViewModel({required this.game , required this.getGameDetailsUseCase , required this.getGameDevelopersUseCase});

  GameDetails? gameDetails;
  String? gameErrorMessage ;

  List<Developers> gameDevelopers = [];
  String? developersErrorMessage ;

  // function to get the game details
  void getGameDetails()async{
    gameDetails = null ;
    gameErrorMessage = null;
    notifyListeners();
    try {
      gameDetails = await getGameDetailsUseCase.invoke(id: game.id.toString());
      notifyListeners();
      getGameDevelopers(id: gameDetails!.id.toString());
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

  // function to return list of rating color meaning
  List<String> getRatingMeaning(){
    return [
      local!.exceptional,
      local!.recommended,
      local!.meh ,
      local!.skip ,
    ];
  }


}