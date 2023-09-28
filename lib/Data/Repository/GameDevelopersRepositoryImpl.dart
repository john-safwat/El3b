import 'package:El3b/Data/DataSource/GameDevelopersRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/GameDevelopersRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:El3b/Domain/Repository/GameDevelopersRepository.dart';


// dependency injection
GameDevelopersRepository injectGameDevelopersRepository(){
  return GameDevelopersRepositoryImpl(remoteDataSource: injectGameDevelopersRemoteDataSource());
}

class GameDevelopersRepositoryImpl implements GameDevelopersRepository {

  GameDevelopersRemoteDataSource remoteDataSource;
  GameDevelopersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Developers>?> getGameDevelopers({required String id}) async{
    var response = await remoteDataSource.getGameDevelopers(id: id);
    return response;
  }

}