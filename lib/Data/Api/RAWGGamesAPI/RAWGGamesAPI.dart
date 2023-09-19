import 'package:El3b/Core/Base/BaseAPIManager.dart';
import 'package:El3b/Data/Api/RAWGGamesAPI/RAWGGamesAPIAssets.dart';
import 'package:El3b/Data/Models/Games/RAWG/RAWGGamesResponseDTO.dart';

// dependency injection
RAWGGamesAPI injectRAWGGamesAPI() {
  return RAWGGamesAPI.getInstance(injectRAWGGamesAPIAssets());
}

class RAWGGamesAPI extends BaseAPIManager<RAWGGamesAPIAssets> {
  // Singleton Pattern
  RAWGGamesAPI._(super.apiAssets);
  static RAWGGamesAPI? _instance;
  static RAWGGamesAPI getInstance(RAWGGamesAPIAssets apiAssets) {
    return _instance ??= RAWGGamesAPI._(apiAssets);
  }

  Future<RAWGGamesResponseDTO?> getGeneralGames() async {
    // prepare the url
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.gamesRoute, {"key": apiAssets.apiKey, "page_size": "20"});
    // make api request
    var response = await dio.getUri(uri);
    // return the data
    return RAWGGamesResponseDTO.fromJson(response.data);
  }

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

}
