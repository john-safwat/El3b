
import 'package:El3b/Data/SQL/LocalDatabase.dart';
import 'package:El3b/Domain/DataSource/GamesCacheLocalDataSource.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';


GamesCacheLocalDataSource injectGamesCacheLocalDataSource(){
  return GamesCacheLocalDataSourceImpl(gamesCache: injectLocalDatabase());
}

class GamesCacheLocalDataSourceImpl implements GamesCacheLocalDataSource {

  LocalDatabase gamesCache;
  GamesCacheLocalDataSourceImpl({required this.gamesCache});

  @override
  Future<void> cacheFreeToPlayGamesData(List<FreeToPlayGame>? games) {
    // TODO: implement cacheFreeToPlayGamesData
    throw UnimplementedError();
  }

  @override
  Future<void> cacheGiveawayGamesData(List<GiveawayGame>? games) {
    // TODO: implement cacheGiveawayGamesData
    throw UnimplementedError();
  }

  @override
  Future<void> cacheRAWGGamesData(List<RAWGGame>? games) {
    // TODO: implement cacheRAWGGamesData
    throw UnimplementedError();
  }

  @override
  Future<List<FreeToPlayGame>?> getCacheFreeToPlayGamesData() {
    // TODO: implement getCacheFreeToPlayGamesData
    throw UnimplementedError();
  }

  @override
  Future<List<GiveawayGame>?> getCacheGiveawayGamesData() {
    // TODO: implement getCacheGiveawayGamesData
    throw UnimplementedError();
  }

  @override
  Future<List<RAWGGame>?> getCacheRAWGGamesData() {
    // TODO: implement getCacheRAWGGamesData
    throw UnimplementedError();
  }

}