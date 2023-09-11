import 'package:El3b/Data/Repository/FreeToPlayGamesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Repository/FreeToPlayGamesRepository.dart';

// dependency injection
GetFreeToPlayGamesUseCase injectGetFreeToPlayGamesUseCase(){
  return GetFreeToPlayGamesUseCase(repository: injectFreeToPlayGamesRepository());
}


class GetFreeToPlayGamesUseCase {

  FreeToPlayGamesRepository repository;
  GetFreeToPlayGamesUseCase({required this.repository});

  Future<List<FreeToPlayGame>> invoke()async{
    var response = await repository.getGames();
    return response!;
  }

}