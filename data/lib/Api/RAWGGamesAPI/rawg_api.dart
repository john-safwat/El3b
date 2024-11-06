import 'package:core/Base/base_api_manager.dart';
import 'package:data/Api/RAWGGamesAPI/rawg_api_assets.dart';
import 'package:data/Models/Achievements/achievements_response_dto.dart';
import 'package:data/Models/Developers/developers_dto.dart';
import 'package:data/Models/Developers/game_developers_dto.dart';
import 'package:data/Models/Games/GameDetails/game_details_dto.dart';
import 'package:data/Models/Games/RAWG/rawg_games_response_dto.dart';
import 'package:data/Models/Genres/genres_response_dto.dart';

// dependency injection
RAWGGamesAPI injectRAWGAPI() {
  return RAWGGamesAPI.getInstance(injectRAWGAPIAssets());
}

class RAWGGamesAPI extends BaseAPIManager<RAWGGamesAPIAssets> {
  // Singleton Pattern
  RAWGGamesAPI._(super.apiAssets);
  static RAWGGamesAPI? _instance;
  static RAWGGamesAPI getInstance(RAWGGamesAPIAssets apiAssets) {
    return _instance ??= RAWGGamesAPI._(apiAssets);
  }

  // function ot get general games for user
  Future<RAWGGamesResponseDTO?> getGeneralGames() async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.gamesRoute, {"key": apiAssets.apiKey, "page_size": "20"});
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return RAWGGamesResponseDTO.fromJson(response.data);
  }

  // function to search for games
  Future<RAWGGamesResponseDTO?> searchForGame({required String query})async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.gamesRoute, {
      "key": apiAssets.apiKey,
      "page_size": "20",
      "search" : query
    });
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return RAWGGamesResponseDTO.fromJson(response.data);
  }

  // function to get genres
  Future<GenresResponseDTO> getAllGenres() async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.genresRoute, {
      "key": apiAssets.apiKey,
      "page_size": "50",
    });
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return GenresResponseDTO.fromJson(response.data);
  }

  // function to get games by genres
  Future<RAWGGamesResponseDTO?> getGamesByGenre({required String genres , required int pageNumber})async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.gamesRoute, {
      "key": apiAssets.apiKey,
      "page_size": "30",
      "page": pageNumber.toString(),
      "genres" : genres,
      "ordering" : "-metacritic"
    });
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return RAWGGamesResponseDTO.fromJson(response.data);
  }


  // function to get the game details from the data base
  Future<GameDetailsDTO> getGameDetails({required String id})async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, "${apiAssets.gamesRoute}/$id", {
      "key": apiAssets.apiKey
    });
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return GameDetailsDTO.fromJson(response.data);
  }


  // function to get the developers of the game
  Future<GameDevelopersDTO?> getGameDevelopers({required String id})async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.gameDevelopmentTeam(id), {
      "key": apiAssets.apiKey
    });
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return GameDevelopersDTO.fromJson(response.data);
  }


  // function to get the achievements of the game
  Future<AchievementsResponseDTO?> getGameAchievements({required String id , required String size , required String pageNumber})async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.gameAchievements(id), {
      "key": apiAssets.apiKey,
      "page_size": size,
      "page": pageNumber

    });
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return AchievementsResponseDTO.fromJson(response.data);
  }

  // function to get the developer Details of the game
  Future<DevelopersDTO?> getGameDeveloperDetails({required String id})async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.gameDeveloper(id), {
      "key": apiAssets.apiKey
    });
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return DevelopersDTO.fromJson(response.data);
  }

}
