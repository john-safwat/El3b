import 'package:El3b/Data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';



// dependency injection
AddGameToHistoryUseCase injectAddGameToHistoryUseCase(){
  return AddGameToHistoryUseCase(repository: injectRAWGGamesRepository());
}

class AddGameToHistoryUseCase {

  RAWGGamesRepository repository ;
  AddGameToHistoryUseCase({required this.repository});


  void invoke({required RAWGGame game , required String uid})async{
    try {
      var gameExist = await repository.gameExist(gameId: game.id.toString(), uid: uid);
      if (gameExist) {
        await repository.deleteGameFromHistory(game: game.id!.toInt(), uid: uid);
        await repository.addGameToHistory(game: game, uid: uid);
      }else {
        await repository.addGameToHistory(game: game, uid: uid);
      }
    }catch(e){
      throw Exception();
    }
  }

}