import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';

abstract class FreeToPlayGamesRepository {

  Future<List<FreeToPlayGame>?> getGames();

}