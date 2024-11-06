import 'package:data/Repository/rawg_games_repository_impl.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/Repository/rawg_games_repository.dart';



// dependency injection
AddGameToHistoryUseCase injectAddGameToHistoryUseCase(){
  return AddGameToHistoryUseCase(repository: injectRAWGGamesRepository());
}

class AddGameToHistoryUseCase {

  RAWGGamesRepository repository ;
  AddGameToHistoryUseCase({required this.repository});


  Future<void> invoke({required RAWGGame game , required String uid})async{
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