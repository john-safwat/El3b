import 'package:El3b/Data/DataSource/RAWGGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/RAWGGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';


// dependency injection
RAWGGamesRepository injectRAWGGamesRepository(){
  return RAWGGamesRepositoryImpl(remoteDataSource: injectRAWGGamesRemoteDataSource());
}


class RAWGGamesRepositoryImpl implements RAWGGamesRepository {

  RAWGGamesRemoteDataSource remoteDataSource ;
  RAWGGamesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<RAWGGame>?> getGeneralGames() async {
    var response = await remoteDataSource.getGeneralGames();
    return response;
  }

}