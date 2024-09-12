import 'package:data/Repository/game_achievements_repository_impl.dart';
import 'package:domain/Models/Achievements/achievement.dart';
import 'package:domain/Repository/game_achievements_repository.dart';


// dependency injection
GetGameAchievementsUseCase injectGetGameAchievementsUseCase(){
  return GetGameAchievementsUseCase(repository: injectGameAchievementsRepository());
}

class GetGameAchievementsUseCase {

  GameAchievementsRepository repository;
  GetGameAchievementsUseCase({required this.repository});

  Future<List<Achievement>> invoke ({required String id})async{
    var response = await repository.getGameAchievements(id: id);
    return response??[];
  }

}