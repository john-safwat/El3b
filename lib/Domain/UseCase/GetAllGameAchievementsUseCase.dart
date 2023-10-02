import 'package:El3b/Domain/Models/Achievements/Achievement.dart';
import 'package:El3b/Domain/Repository/GameAchievementsRepository.dart';

class GetAllGameAchievementsUseCase {

  GameAchievementsRepository repository ;
  GetAllGameAchievementsUseCase({required this.repository});

  Future<(String? , List<Achievement>)> invoke({required String id})async{
    var (next , response) = await repository.getAllAGameAchievements(id: id);
    return (next , response??[]);
  }

}