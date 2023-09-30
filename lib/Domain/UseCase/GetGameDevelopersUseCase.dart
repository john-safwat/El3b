
import 'package:El3b/Data/Repository/GameDevelopersRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:El3b/Domain/Repository/GameDevelopersRepository.dart';


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