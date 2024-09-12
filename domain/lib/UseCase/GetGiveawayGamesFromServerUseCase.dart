import 'package:data/Repository/GiveawayGamesRepositoryImpl.dart';
import 'package:domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:domain/Repository/GiveawayGamesRepository.dart';


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