import 'package:El3b/Data/DataSource/FreeToPlayGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Data/DataSource/GamesCacheLocalDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/FreeToPlayGamesRemoteDataSource.dart';
import 'package:El3b/Domain/DataSource/GamesCacheLocalDataSource.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Repository/FreeToPlayGamesRepository.dart';


// dependency injection
FreeToPlayGamesRepository injectFreeToPlayGamesRepository(){
  return FreeToPlayGamesRepositoryImpl(
    remoteDataSource: injectFreeToPlayGamesRemoteDataSource(),
    cacheLocalDataSource: injectGamesCacheLocalDataSource(),
  );
}

class FreeToPlayGamesRepositoryImpl implements FreeToPlayGamesRepository {

  FreeToPlayGamesRemoteDataSource remoteDataSource;
  GamesCacheLocalDataSource cacheLocalDataSource;
  FreeToPlayGamesRepositoryImpl({required this.remoteDataSource , required this.cacheLocalDataSource});

  // function to load free to play game from api throw data source
  @override
  Future<List<FreeToPlayGame>?> getGames() async{
    var response = await remoteDataSource.getGames();
    return response;
  }

}