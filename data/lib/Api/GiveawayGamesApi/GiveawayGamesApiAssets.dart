import 'package:core/Base/BaseAPIAssets.dart';

// dependency injection
GiveawayGamesApiAssets injectGiveawayGamesApiAssets(){
  return GiveawayGamesApiAssets.getInstance();
}

// the object code
class GiveawayGamesApiAssets extends BaseAPIAssets{

  // singleton object
  GiveawayGamesApiAssets._();
  static GiveawayGamesApiAssets? _instance ;
  static getInstance(){
    return _instance??=GiveawayGamesApiAssets._();
  }


  String baseURL = "www.gamerpower.com";
  String giveawayRoute = "/api/giveaways";

}