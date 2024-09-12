import 'package:core/Base/BaseAPIManager.dart';
import 'package:data/Api/GiveawayGamesApi/GiveawayGamesApiAssets.dart';
import 'package:data/Models/Games/GiveawayGame/GiveawayGameDTO.dart';
// dependency injection
GiveawayGamesApi injectGiveawayGamesApi(){
  return GiveawayGamesApi.getInstance(apiAssets: injectGiveawayGamesApiAssets());
}


class GiveawayGamesApi extends BaseAPIManager<GiveawayGamesApiAssets>{

  GiveawayGamesApi._(super.apiAssets);

  static GiveawayGamesApi? _instance;
  static GiveawayGamesApi getInstance({required GiveawayGamesApiAssets apiAssets}){
    return _instance??= GiveawayGamesApi._(apiAssets);
  }

  // function to load giveaway game from api
  Future<List<GiveawayGameDTO>?> getAllGames() async{
    // make the url ready for calling
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.giveawayRoute,);
    // call the api
    var response = await dio.get<List<dynamic>>(uri.toString());
    // return response
    return response.data!.map((e) => GiveawayGameDTO.fromJson(e)).toList();
  }


}

