import 'package:El3b/Data/DataSource/GamesCacheLocalDataSourceImpl.dart';
import 'package:El3b/Data/DataSource/RAWGGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/GamesCacheLocalDataSource.dart';
import 'package:El3b/Domain/DataSource/RAWGGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';


// dependency injection
RAWGGamesRepository injectRAWGGamesRepository(){
  return RAWGGamesRepositoryImpl(
    remoteDataSource: injectRAWGGamesRemoteDataSource(),
    gamesCacheLocalDataSource: injectGamesCacheLocalDataSource()
  );
}


class RAWGGamesRepositoryImpl implements RAWGGamesRepository {

  RAWGGamesRemoteDataSource remoteDataSource ;
  GamesCacheLocalDataSource gamesCacheLocalDataSource;
  RAWGGamesRepositoryImpl({required this.remoteDataSource , required this.gamesCacheLocalDataSource});

  // function to get the games to the home screen
  @override
  Future<List<RAWGGame>?> getGeneralGames() async {
    var response = await remoteDataSource.getGeneralGames();
    return response;
  }

}