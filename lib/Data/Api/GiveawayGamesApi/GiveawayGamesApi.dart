import 'package:El3b/Core/Base/BaseAPIManager.dart';
import 'package:El3b/Data/Api/GiveawayGamesApi/GiveawayGamesApiAssets.dart';
import 'package:El3b/Data/Models/Games/GiveawayGames/GiveawayGamesDTO.dart';
// dependency injection
GiveawayGamesApi injectGiveawayGamesApi(){
  return GiveawayGamesApi.getInstance(apiAssets: injectGiveawayGamesApiAssets());
}


class GiveawayGamesApi extends BaseAPIManager<GiveawayGamesApiAssets>{

  GiveawayGamesApi._({required GiveawayGamesApiAssets apiAssets}):super(apiAssets);

  static GiveawayGamesApi? _instance;
  static GiveawayGamesApi getInstance({required GiveawayGamesApiAssets apiAssets}){
    return _instance??= GiveawayGamesApi._(apiAssets: apiAssets);
  }

  // function to load giveaway game from api
  Future<List<GiveawayGamesDTO>?> getAllGames() async{
    // make the url ready for calling
    Uri uri = Uri.https(apiAssets.baseURL, apiAssets.giveawayRoute,);
    // call the api
    var response = await dio.get<List<dynamic>>(uri.toString());
    // return response
    return response.data!.map((e) => GiveawayGamesDTO.fromJson(e)).toList();
  }


}


