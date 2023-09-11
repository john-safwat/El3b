import 'package:El3b/Data/DataSource/FreeToPlayGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/FreeToPlayGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Repository/FreeToPlayGamesRepository.dart';


// dependency injection
FreeToPlayGamesRepository injectFreeToPlayGamesRepository(){
  return FreeToPlayGamesRepositoryImpl(remoteDataSource: injectFreeToPlayGamesRemoteDataSource());
}

class FreeToPlayGamesRepositoryImpl implements FreeToPlayGamesRepository {

  FreeToPlayGamesRemoteDataSource remoteDataSource;
  FreeToPlayGamesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<FreeToPlayGame>?> getGames() async{
    var response = await remoteDataSource.getGames();
    return response;
  }

}