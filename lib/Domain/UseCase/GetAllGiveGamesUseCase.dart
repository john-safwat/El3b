import 'package:El3b/Data/Repository/GiveawayGamesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Repository/GiveawayGamesRepository.dart';

// dependency injection
GetAllGiveGamesUseCase injectGetAllGiveGamesUseCase(){
  return GetAllGiveGamesUseCase(repository: injectGiveawayGamesRepository());
}

class GetAllGiveGamesUseCase {

  GiveawayGamesRepository repository;
  GetAllGiveGamesUseCase({required this.repository});

  // function to load giveaway game from api
  Future<List<GiveawayGame>> invoke()async{
    var response = await repository.getAllGames();
    return response!;
  }

}