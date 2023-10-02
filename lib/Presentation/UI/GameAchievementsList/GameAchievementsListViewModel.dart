import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/UseCase/GetAllGameAchievementsUseCase.dart';
import 'package:El3b/Presentation/UI/GameAchievementsList/GameAchievementsListNavigator.dart';

class GameAchievementsListViewModel extends BaseViewModel<GameAchievementsListNavigator>{

  String gameId;
  GetAllGameAchievementsUseCase getAllGameAchievementsUseCase;
  GameAchievementsListViewModel({required this.gameId , required  this.getAllGameAchievementsUseCase});

}