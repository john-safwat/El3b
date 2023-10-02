import 'package:El3b/Data/DataSource/GameAchievementsRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/GameAchievementsRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Achievements/Achievement.dart';
import 'package:El3b/Domain/Repository/GameAchievementsRepository.dart';


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
  Future<(String?, List<Achievement>?)> getAllAGameAchievements({required String id}) async{
    var response = await remoteDataSource.getAllAGameAchievements(id: id);
    return response;
  }

}