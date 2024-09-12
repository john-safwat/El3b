
import 'package:core/Base/BaseViewModel.dart';
import 'package:domain/Models/Achievements/Achievement.dart';
import 'package:domain/UseCase/GetAllGameAchievementsUseCase.dart';
import 'package:presentation/UI/GameAchievementsList/GameAchievementsListNavigator.dart';

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
      errorMessage = handleExceptions(e as Exception);
      notifyListeners();
    }
  }

  addList (List<Achievement> achievements){
    for(int i = 0 ; i<achievements.length ; i++){
      this.achievements.add(achievements[i]);
    }
  }

}