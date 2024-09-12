import 'package:domain/Models/Games/FreeToPlayGame/free_to_play_game.dart';
import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/Models/Genres/genre.dart';

abstract class CacheDataLocalDataSource {

  Future<DateTime?> getLastUpdatedDate({required String key});
  Future<void> cacheData({required String data , required String key});
  Future<List<GiveawayGame>?> getGiveawayGames();
  Future<List<FreeToPlayGame>?> getFreeToPlayGames();
  Future<List<RAWGGame>?> getGeneralGames();
  Future<List<Genre>?> getGenresList();
}