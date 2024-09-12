import 'package:data/Repository/GameDevelopersRepositoryImpl.dart';
import 'package:domain/Models/Developers/Developers.dart';
import 'package:domain/Repository/GameDevelopersRepository.dart';


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