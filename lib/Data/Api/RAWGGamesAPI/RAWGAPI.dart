import 'package:El3b/Core/Base/BaseAPIManager.dart';
import 'package:El3b/Data/Api/RAWGGamesAPI/RAWGAPIAssets.dart';
import 'package:El3b/Data/Models/Games/GameDetails/GameDetailsDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/RAWGGamesResponseDTO.dart';
import 'package:El3b/Data/Models/Genres/GenresResponseDTO.dart';

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

}
