
import 'package:El3b/Data/DataSource/GiveawayGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/GiveawayGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Repository/GiveawayGamesRepository.dart';

// dependency injection
GiveawayGamesRepository injectGiveawayGamesRepository(){
  return GiveawayGamesRepositoryImpl(
    remoteDataSource: injectGiveawayGamesRemoteDataSource(),
  );
}

// the object
class GiveawayGamesRepositoryImpl implements GiveawayGamesRepository {

  GiveawayGamesRemoteDataSource remoteDataSource ;
  GiveawayGamesRepositoryImpl({required this.remoteDataSource});

  // function to load giveaway game from api throw data source
  @override
  Future<List<GiveawayGame>?> getAllGames() async{
    var response = await remoteDataSource.getAllGames();
    return response;
  }

}