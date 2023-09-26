
import 'package:El3b/Domain/Models/Games/GameDetails/GameDetails.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

abstract class RAWGGamesRepository {

  Future<List<RAWGGame>?> getGeneralGames();
  Future<List<RAWGGame>?> searchForGame({required String query});

  Future<int> addGameToWishList({required RAWGGame game ,required String uid});
  Future<int> deleteGameFromWishList({required int game ,required String uid});
  Future<List<RAWGGame>?> loadGamesFromWishList({required String uid});

  Future<(num? , List<RAWGGame>?)> getGamesByGenre({required String genre , required int pageNumber});

  Future<GameDetails?> getGameDetails({required String id});

}