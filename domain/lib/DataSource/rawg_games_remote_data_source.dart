
import 'package:domain/Models/Games/GameDetails/game_details.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';

abstract class RAWGGamesRemoteDataSource {

  Future<List<RAWGGame>?> getGeneralGames();
  Future<List<RAWGGame>?> searchForGame({required String query});
  Future<(num? , List<RAWGGame>?)> getGamesByGenre({required String genre , required int pageNumber});
  Future<GameDetails?> getGameDetails({required String id});

}