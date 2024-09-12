import 'package:domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';

abstract class FreeToPlayGamesRepository {

  Future<List<FreeToPlayGame>?> getGames();

}