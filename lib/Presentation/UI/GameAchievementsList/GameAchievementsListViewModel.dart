import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Achievements/Achievement.dart';
import 'package:El3b/Domain/UseCase/GetAllGameAchievementsUseCase.dart';
import 'package:El3b/Presentation/UI/GameAchievementsList/GameAchievementsListNavigator.dart';

class GameAchievementsListViewModel extends BaseViewModel<GameAchievementsListNavigator>{

  String gameId;
  GetAllGameAchievementsUseCase getAllGameAchievementsUseCase;
  GameAchievementsListViewModel({required this.gameId , required  this.getAllGameAchievementsUseCase});

  String? errorMessage;
  String? next;
  int pageNumber = 1;
  List<Achievement> achievements = [];

  getGameAchievements()async{
    errorMessage  = null ;
    try {
      List<Achievement> data = [];
      String? nextPage;
      (nextPage , data) = await getAllGameAchievementsUseCase.invoke(id: gameId , pageNumber: pageNumber.toString());
      next = nextPage;
      addList(data);
      if(nextPage != null){
        pageNumber++;
      }
      notifyListeners();
    }catch (e){
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

  addList (List<Achievement> achievements){
    for(int i = 0 ; i<achievements.length ; i++){
      this.achievements.add(achievements[i]);
    }
  }

}