import 'package:El3b/Data/Repository/GameAchievementsRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Achievements/Achievement.dart';
import 'package:El3b/Domain/Repository/GameAchievementsRepository.dart';



// dependency injections
GetAllGameAchievementsUseCase injectGetAllGameAchievementsUseCase(){
  return GetAllGameAchievementsUseCase(repository: injectGameAchievementsRepository());
}


class GetAllGameAchievementsUseCase {

  GameAchievementsRepository repository ;
  GetAllGameAchievementsUseCase({required this.repository});

  Future<(String? , List<Achievement>)> invoke({required String id ,  required String pageNumber})async{
    var (next , response) = await repository.getAllAGameAchievements(id: id , pageNumber: pageNumber);
    return (next , response??[]);
  }

}