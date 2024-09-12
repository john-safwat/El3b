import 'package:data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/Repository/RAWGGamesRepository.dart';


// dependency injection
SearchFromGameFromServerUseCase injectSearchFromGameFromServerUseCase(){
  return SearchFromGameFromServerUseCase(repository: injectRAWGGamesRepository());
}


class SearchFromGameFromServerUseCase {

  RAWGGamesRepository repository;
  SearchFromGameFromServerUseCase({required this.repository});


  Future<List<RAWGGame>> invoke({required String query , required String uid})async {
    var response = await repository.searchForGame(query: query);
    var favorite = await repository.loadGamesFromWishList(uid: uid);
    response = addStoresIcons(response!);
    response = noNullValue(response);
    response = wishListGames(response , favorite!);
    return response??[];
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

  // validate on wish list value set the games in wish list  the inWishlist value to true
  List<RAWGGame> wishListGames(List<RAWGGame> games , List<RAWGGame> favorite){
    for (int i = 0 ; i<games.length ; i++){
      for (int j =0 ; j<favorite.length ; j++){
        if(games[i].id! == favorite[j].id){
          games[i].inWishList = true;
        }
      }
    }
    return games;
  }

}