import 'package:El3b/Core/Base/BaseAPIAssets.dart';


// dependency injection
RAWGGamesAPIAssets injectRAWGAPIAssets (){
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
  String genresRoute = "/api/genres";
  String gameDetailsRoute = "/api/games/";
  String gameDeveloperDetails = "/api/creators/";
  String apiKey = "58cb6e3d5f144d9ab9600c3cd1985820";

  String gameDevelopmentTeam (String id){
    return "/api/games/$id/development-team";
  }

  String gameAchievements (String id){
    return "/api/games/$id/achievements";
  }

  String gameDeveloper (String id){
    return "$gameDeveloperDetails$id";
  }

}