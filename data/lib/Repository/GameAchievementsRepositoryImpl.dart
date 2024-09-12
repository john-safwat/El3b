import 'package:data/DataSource/GameAchievementsRemoteDataSourceImpl.dart';
import 'package:domain/DataSource/GameAchievementsRemoteDataSource.dart';
import 'package:domain/Models/Achievements/Achievement.dart';
import 'package:domain/Repository/GameAchievementsRepository.dart';


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