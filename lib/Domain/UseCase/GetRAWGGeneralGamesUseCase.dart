
import 'package:El3b/Data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';


// dependency injection
GetRAWGGeneralGamesUseCase injectGetRAWGGeneralGamesUseCase() {
  return GetRAWGGeneralGamesUseCase(repository: injectRAWGGamesRepository());
}


class GetRAWGGeneralGamesUseCase {

  RAWGGamesRepository repository;
  GetRAWGGeneralGamesUseCase({required this.repository});

  Future<List<RAWGGame>> invoke() async {
    var response = await repository.getGeneralGames();
    return response!;
  }

}