
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

abstract class RAWGGamesRemoteDataSource {

  Future<List<RAWGGame>?> getGeneralGames();
  Future<List<RAWGGame>?> searchForGame({required String query});
  Future<(num? , List<RAWGGame>?)> getGamesByGenre({required String genre , required int pageNumber});
}