import 'package:domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/Models/Genres/Genre.dart';

abstract class CacheDataLocalDataSource {

  Future<DateTime?> getLastUpdatedDate({required String key});
  Future<void> cacheData({required String data , required String key});
  Future<List<GiveawayGame>?> getGiveawayGames();
  Future<List<FreeToPlayGame>?> getFreeToPlayGames();
  Future<List<RAWGGame>?> getGeneralGames();
  Future<List<Genre>?> getGenresList();
}