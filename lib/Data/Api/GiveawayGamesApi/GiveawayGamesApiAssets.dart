// dependency injection

import 'package:El3b/Data/Models/Games/GiveawayGames/GiveawayGamesDTO.dart';

GiveawayGamesApiAssets injectGiveawayGamesApiAssets(){
  return GiveawayGamesApiAssets.getInstance();
}

// the object code
class GiveawayGamesApiAssets {

  // singleton object
  GiveawayGamesApiAssets._();
  static GiveawayGamesApiAssets? _instance ;
  static getInstance(){
    return _instance??=GiveawayGamesApiAssets._();
  }

  String basUrl = "www.gamerpower.com";
  String giveawayRoute = "/api/giveaways";

}