import 'package:core/Base/base_api_manager.dart';
import 'package:data/Api/FreeToPlayGamesApi/free_to_play_games_api_assets.dart';
import 'package:data/Models/Games/FreeToPlayGame/free_to_play_game_dto.dart';

// dependency injection
FreeToPlayGamesApi injectFreeToPlayGamesApi(){
  return FreeToPlayGamesApi.getInstance(injectFreeToPlayGamesApiAssets());
}


class FreeToPlayGamesApi extends BaseAPIManager <FreeToPlayGamesApiAssets> {

  // singleton pattern
  FreeToPlayGamesApi._(super.apiAssets);
  static FreeToPlayGamesApi? _instance ;
  static FreeToPlayGamesApi getInstance(FreeToPlayGamesApiAssets apiAssets){
    return _instance??= FreeToPlayGamesApi._(apiAssets);
  }

  Future<List<FreeToPlayGameDTO>?> getGames()async{
    // make the url ready for calling
    var uri = Uri.https(apiAssets.baseURL , apiAssets.freeToPlayGamesRoute);
    // call the api
    var response = await dio.getUri<List<dynamic>>(uri);
    // return response
    return response.data!.map((e) => FreeToPlayGameDTO.fromJson(e)).toList();
  }

}