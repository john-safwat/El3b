
import 'package:El3b/Data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';


// dependency injection
GetRAWGGeneralGamesUseCase injectGetRAWGGeneralGamesUseCase() {
  return GetRAWGGeneralGamesUseCase(repository: injectRAWGGamesRepository());
}


class GetRAWGGeneralGamesUseCase {

  RAWGGamesRepository repository;
  GetRAWGGeneralGamesUseCase({required this.repository});


  // load games from api
  Future<List<RAWGGame>> invoke() async {
    var response = await repository.getGeneralGames();
    response = addStoresIcons(response!);
    response = noNullValue(response);
    return response;
  }

  // add stores icons
  List<RAWGGame> addStoresIcons(List<RAWGGame> games){
    for(int i = 0; i< games.length ; i++){
      for(int j = 0 ; j < games[i].stores!.length ; j++){
        switch (games[i].stores![j].name){
          case "Steam" :
            games[i].icons.add("Assets/SVG/steam.svg");
          break;
          case "PlayStation Store" :
            games[i].icons.add("Assets/SVG/playstation.svg");
          break;
          case "Xbox Store" :
            games[i].icons.add("Assets/SVG/xbox.svg");
          break;
          case "App Store" :
            games[i].icons.add("Assets/SVG/app-store.svg");
          break;
          case "GOG" :
            games[i].icons.add("Assets/SVG/gog-dot-com.svg");
          break;
          case "Nintendo Store" :
            games[i].icons.add("Assets/SVG/nintendo-switch.svg");
          break;
          case "Google Play" :
            games[i].icons.add("Assets/SVG/google-play-store.svg");
          break;
          case "itch.io" :
            games[i].icons.add("Assets/SVG/itch-io.svg");
          break;
          case "Epic Games" :
            games[i].icons.add("Assets/SVG/epic-games.svg");
          break;
        }
      }
    }
    return games;

  }

  // make sure thant no null value is passed
  List<RAWGGame> noNullValue(List<RAWGGame> games) {
    for(int i = 0; i< games.length ; i++){
      if(games[i].metacritic == null){
        games[i].metacritic = 0;
      }

      if(games[i].rating == null){
        games[i].rating = 0;
      }
    }

    return games;
  }


}