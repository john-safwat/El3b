import 'package:data/Repository/free_to_play_games_repository_impl.dart';
import 'package:domain/Models/Games/FreeToPlayGame/free_to_play_game.dart';
import 'package:domain/Repository/free_to_play_games_repository.dart';

// dependency injection
GetFreeToPlayGamesUseCase injectGetFreeToPlayGamesUseCase(){
  return GetFreeToPlayGamesUseCase(repository: injectFreeToPlayGamesRepository());
}


class GetFreeToPlayGamesUseCase {

  FreeToPlayGamesRepository repository;
  GetFreeToPlayGamesUseCase({required this.repository});

  Future<List<FreeToPlayGame>> invoke()async{
    var response = await repository.getGames();
    response = changePlatformToIcon(response!);
    return response;
  }

  // change the platform name to Icon
  List<FreeToPlayGame> changePlatformToIcon(List<FreeToPlayGame> games){
    for(int i = 0 ; i < games.length ; i++){
      if (games[i].platform == 'PC (Windows)'){
        games[i].icon = "Assets/SVG/windows.svg";
      }else {
        games[i].icon = "Assets/SVG/browser.svg";
      }
    }
    return games;
  }

}