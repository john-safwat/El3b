import 'package:El3b/Core/Base/BaseAPIAssets.dart';


// dependency injection
RAWGGamesAPIAssets injectRAWGGamesAPIAssets (){
  return RAWGGamesAPIAssets.getInstance();
}

class RAWGGamesAPIAssets extends BaseAPIAssets {

  // singleton pattern
  RAWGGamesAPIAssets._();
  static RAWGGamesAPIAssets? _instance;
  static RAWGGamesAPIAssets getInstance(){
    return _instance ??= RAWGGamesAPIAssets._();
  }


  String baseURL =  'api.rawg.io';
  String gamesRoute = "/api/games";
  String apiKey = "58cb6e3d5f144d9ab9600c3cd1985820";

}