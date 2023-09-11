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
    response = addGamesIcons(response!);
    return response;
  }

  // function to add the icons of the stores
  List<GiveawayGame> addGamesIcons(List<GiveawayGame> games){
    for (int i = 0 ; i<games.length ; i++){
      if (games[i].platforms!.contains("PC")){
        games[i].icons.add("Assets/SVG/windows.svg");
      }
      if (games[i].platforms!.contains("Steam")){
        games[i].icons.add("Assets/SVG/steam.svg");
      }
      if (games[i].platforms!.contains("Epic Games Store")){
        games[i].icons.add("Assets/SVG/epic-games.svg");
      }
      if (games[i].platforms!.contains("Itch.io")){
        games[i].icons.add("Assets/SVG/itch-io.svg");
      }
      if (games[i].platforms!.contains("GOG")){
        games[i].icons.add("Assets/SVG/gog-dot-com.svg");
      }
      if (games[i].platforms!.contains("Xbox One")){
        games[i].icons.add("Assets/SVG/xbox.svg");
      }
      if (games[i].platforms!.contains("Playstation")){
        games[i].icons.add("Assets/SVG/playstation.svg");
      }
      if (games[i].platforms!.contains("Nintendo")){
        games[i].icons.add("Assets/SVG/nintendo-switch.svg");
      }
      if (games[i].platforms!.contains("Android")){
        games[i].icons.add("Assets/SVG/google-play-store.svg");
      }
      if (games[i].platforms!.contains("iOS")){
        games[i].icons.add("Assets/SVG/app-store.svg");
      }
    }
    return games;
  }

}









