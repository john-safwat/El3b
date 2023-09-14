import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

abstract class GamesCacheLocalDataSource {

  Future<void> cacheGiveawayGamesData(List<GiveawayGame>? games);
  Future<List<GiveawayGame>?> getCacheGiveawayGamesData();
  Future<void> cacheFreeToPlayGamesData(List<FreeToPlayGame>? games);
  Future<List<FreeToPlayGame>?> getCacheFreeToPlayGamesData();
  Future<void> cacheRAWGGamesData(List<RAWGGame>? games);
  Future<List<RAWGGame>?> getCacheRAWGGamesData();

}