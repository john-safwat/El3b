import 'package:domain/Models/Games/RAWG/rawg_game.dart';

abstract class GamesListLocalDataSource{

  Future<int> addGameToWishList({required RAWGGame game ,required String uid});
  Future<int> deleteGameFromWishList({required int game ,required String uid});
  Future<List<RAWGGame>?> loadGamesFromWishList({required String uid});
  Future<int> addGameToHistory({required RAWGGame game ,required String uid});
  Future<int> deleteGameFromHistory({required int game ,required String uid});
  Future<List<RAWGGame>?> loadGamesFromHistory({required String uid});
  Future<bool> gameExist({required String gameId , required String uid});

}