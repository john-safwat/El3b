import 'package:data/Repository/giveaway_games_repository_impl.dart';
import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';
import 'package:domain/Repository/giveaway_games_repository.dart';


// dependency injection
GetGiveawayGamesFromServerUseCase injectGetGiveawayGamesFromServerUseCase(){
  return GetGiveawayGamesFromServerUseCase(repository: injectGiveawayGamesRepository());
}


class GetGiveawayGamesFromServerUseCase {

  GiveawayGamesRepository repository;
  GetGiveawayGamesFromServerUseCase({required this.repository});

  Future<List<GiveawayGame>> invoke()async{
    var response = await repository.getDataFromServer();
    return response??[];
  }

}