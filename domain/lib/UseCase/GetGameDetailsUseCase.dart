import 'package:data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:domain/Models/Games/GameDetails/GameDetails.dart';
import 'package:domain/Repository/RAWGGamesRepository.dart';


GetGameDetailsUseCase injectGetGameDetailsUseCase(){
  return GetGameDetailsUseCase(repository: injectRAWGGamesRepository());
}

class GetGameDetailsUseCase {

  RAWGGamesRepository repository ;
  GetGameDetailsUseCase ({required this.repository});


  Future<GameDetails?> invoke({required String id})async{
    var response = await repository.getGameDetails(id: id);
    response = addStoreIcon(response);
    response = noNullValueInMetaciRating(response);
    return response;
  }

  // add stores icon
  GameDetails? addStoreIcon ( GameDetails? game){
    if( game?.stores != null){
      for (int i = 0; i < game!.stores!.length ; i++){
        if(game.stores![i].store?.name != null){
          switch (game.stores![i].store?.name){
            case "Steam" :
              game.stores![i].store?.icon = "Assets/SVG/steam.svg" ;
              break;
            case "PlayStation Store" :
              game.stores![i].store?.icon = "Assets/SVG/playstation.svg";
              break;
            case "Xbox Store" :
              game.stores![i].store?.icon ="Assets/SVG/xbox.svg";
              break;
            case "App Store" :
              game.stores![i].store?.icon ="Assets/SVG/app-store.svg" ;
              break;
            case "GOG" :
              game.stores![i].store?.icon ="Assets/SVG/gog-dot-com.svg";
              break;
            case "Nintendo Store" :
              game.stores![i].store?.icon ="Assets/SVG/nintendo-switch.svg";
              break;
            case "Google Play" :
              game.stores![i].store?.icon ="Assets/SVG/google-play-store.svg";
              break;
            case "itch.io" :
              game.stores![i].store?.icon ="Assets/SVG/itch-io.svg";
              break;
            case "Epic Games" :
              game.stores![i].store?.icon ="Assets/SVG/epic-games.svg";
              break;
          }
        }
      }
    }
    return game;
  }


  // check for the null value in the game rating
  GameDetails? noNullValueInMetaciRating ( GameDetails? game){
    if (game?.metacriticPlatforms != null){
      for (int i =0 ; i< game!.metacriticPlatforms!.length ; i++){
        if (game.metacriticPlatforms![i].platform != null){
          if (game.metacriticPlatforms![i].platform!.name!.contains("PlayStation")){
            game.metacriticPlatforms![i].platform!.icon = "Assets/SVG/playstation.svg";
          }else if (game.metacriticPlatforms![i].platform!.name!.contains("Xbox One")){
            game.metacriticPlatforms![i].platform!.icon = "Assets/SVG/xbox.svg";
          }else {
            game.metacriticPlatforms![i].platform!.icon = "Assets/SVG/windows.svg";
          }
        }
      }
    }
    return game;
  }

}