import 'package:data/DataSource/GameDevelopersRemoteDataSourceImpl.dart';
import 'package:domain/DataSource/GameDevelopersRemoteDataSource.dart';
import 'package:domain/Models/Developers/Developers.dart';
import 'package:domain/Repository/GameDevelopersRepository.dart';


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