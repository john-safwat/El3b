import 'package:El3b/Data/Repository/GiveawayGamesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Repository/GiveawayGamesRepository.dart';


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