import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

abstract class CacheDataLocalDataSource {

  Future<DateTime?> getLastUpdatedDate({required String key});
  Future<void> cacheData({required String data , required String key});
  Future<List<GiveawayGame>?> getGiveawayGames();
  Future<List<FreeToPlayGame>?> getFreeToPlayGames();
  Future<List<RAWGGame>?> getGeneralGames();


}