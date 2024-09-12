import 'package:data/Repository/game_developers_repository_impl.dart';
import 'package:domain/Models/Developers/developers.dart';
import 'package:domain/Repository/game_developers_repository.dart';


// dependency injection
GetGameDeveloperDetailsUseCase injectGetGameDeveloperDetailsUseCase(){
  return GetGameDeveloperDetailsUseCase(repository: injectGameDevelopersRepository());
}


class GetGameDeveloperDetailsUseCase {

  GameDevelopersRepository repository ;
  GetGameDeveloperDetailsUseCase ({required this.repository});

  Future<Developer> invoke({required String id })async {
    var response  = await repository.getGameDeveloperDetails(id: id);
    return response!;
  }

}