import 'package:data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/Repository/RAWGGamesRepository.dart';


// dependency injection
GetGamesForWishListUseCase injectGetGamesForWishListUseCase(){
  return GetGamesForWishListUseCase(repository: injectRAWGGamesRepository());
}

class GetGamesForWishListUseCase {

  RAWGGamesRepository repository;
  GetGamesForWishListUseCase({required this.repository});

  Future<List<RAWGGame>> invoke({required String uid})async{
    var response = await repository.loadGamesFromWishList(uid: uid);
    response = changeWishListState(response??[]);
    response = addStoresIcons(response);
    response = noNullValue(response);

    List<RAWGGame> games = [];
    for(int i = response.length-1 ; i>=0 ;i-- ){
      games.add(response[i]);
    }

    return games;
  }

  // mark all games as in wishlist
  List<RAWGGame> changeWishListState(List<RAWGGame> games){
    for (int i = 0 ; i<games.length ; i++){
      games[i].inWishList = true;
    }
    return games;
  }

  // add stores icons
  List<RAWGGame> addStoresIcons(List<RAWGGame> games){
    for(int i = 0; i< games.length ; i++){
      if(games[i].stores != null){
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