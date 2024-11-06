import 'package:data/DataSource/game_achievements_remote_data_source_impl.dart';
import 'package:domain/DataSource/game_achievements_remote_data_source.dart';
import 'package:domain/Models/Achievements/achievement.dart';
import 'package:domain/Repository/game_achievements_repository.dart';


GameAchievementsRepository injectGameAchievementsRepository(){
  return GameAchievementsRepositoryImpl(remoteDataSource: injectGameAchievementsRemoteDataSource());
}

class GameAchievementsRepositoryImpl implements GameAchievementsRepository{

  GameAchievementsRemoteDataSource remoteDataSource;
  GameAchievementsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Achievement>?> getGameAchievements({required String id}) async{
    var response = await remoteDataSource.getGameAchievements(id: id);
    return response;
  }

  @override
  Future<(String?, List<Achievement>?)> getAllAGameAchievements({required String id ,  required String pageNumber}) async{
    var response = await remoteDataSource.getAllAGameAchievements(id: id , pageNumber: pageNumber);
    return response;
  }

}