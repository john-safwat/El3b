
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

abstract class RAWGGamesRemoteDataSource {

  Future<List<RAWGGame>?> getGeneralGames();

}