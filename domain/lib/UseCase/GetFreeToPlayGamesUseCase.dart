import 'package:data/Repository/FreeToPlayGamesRepositoryImpl.dart';
import 'package:domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:domain/Repository/FreeToPlayGamesRepository.dart';

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