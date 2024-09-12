
import 'package:data/Repository/GameDevelopersRepositoryImpl.dart';
import 'package:domain/Models/Developers/Developers.dart';
import 'package:domain/Repository/GameDevelopersRepository.dart';


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