
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

abstract class RAWGGamesRepository {

  Future<List<RAWGGame>?> getGeneralGames();

}