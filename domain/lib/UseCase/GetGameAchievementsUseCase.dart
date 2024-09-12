import 'package:data/Repository/GameAchievementsRepositoryImpl.dart';
import 'package:domain/Models/Achievements/Achievement.dart';
import 'package:domain/Repository/GameAchievementsRepository.dart';


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