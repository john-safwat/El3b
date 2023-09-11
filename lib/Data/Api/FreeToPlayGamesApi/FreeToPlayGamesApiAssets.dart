import 'package:El3b/Core/Base/BaseAPIAssets.dart';

// Dependency injection
FreeToPlayGamesApiAssets injectFreeToPlayGamesApiAssets(){
  return FreeToPlayGamesApiAssets.getFreeToPlayGamesApiAssets();
}


class FreeToPlayGamesApiAssets extends BaseAPIAssets {

  // singleton pattern
  FreeToPlayGamesApiAssets._();
  static FreeToPlayGamesApiAssets? _instance;
  static FreeToPlayGamesApiAssets getFreeToPlayGamesApiAssets(){
    return _instance??= FreeToPlayGamesApiAssets._();
  }


  String baseURL = "www.freetogame.com";
  String freeToPlayGamesRoute = "/api/games";


}