import 'package:El3b/Data/Repository/GameDevelopersRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:El3b/Domain/Repository/GameDevelopersRepository.dart';


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