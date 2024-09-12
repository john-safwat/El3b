
import 'package:data/Repository/game_developers_repository_impl.dart';
import 'package:domain/Models/Developers/developers.dart';
import 'package:domain/Repository/game_developers_repository.dart';


// dependency injection
GetGameDevelopersUseCase injectGetGameDevelopersUseCase(){
  return GetGameDevelopersUseCase(repository: injectGameDevelopersRepository());
}


class GetGameDevelopersUseCase {

  GameDevelopersRepository repository;
  GetGameDevelopersUseCase({required this.repository});

  Future<List<Developer>> invoke({required String id}) async {

    var response = await repository.getGameDevelopers(id: id);
    return response??[];

  }


} 