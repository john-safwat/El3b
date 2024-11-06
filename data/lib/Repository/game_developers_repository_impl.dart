import 'package:data/DataSource/game_developers_remote_data_source_impl.dart';
import 'package:domain/DataSource/game_developers_remote_data_source.dart';
import 'package:domain/Models/Developers/developers.dart';
import 'package:domain/Repository/game_developers_repository.dart';


// dependency injection
GameDevelopersRepository injectGameDevelopersRepository(){
  return GameDevelopersRepositoryImpl(remoteDataSource: injectGameDevelopersRemoteDataSource());
}

class GameDevelopersRepositoryImpl implements GameDevelopersRepository {

  GameDevelopersRemoteDataSource remoteDataSource;
  GameDevelopersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Developer>?> getGameDevelopers({required String id}) async{
    var response = await remoteDataSource.getGameDevelopers(id: id);
    return response;
  }

  @override
  Future<Developer?> getGameDeveloperDetails({required String id}) async{
    var response = await remoteDataSource.getGameDeveloperDetails(id: id);
    return response;
  }

}