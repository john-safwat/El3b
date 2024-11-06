import 'package:domain/Models/Games/FreeToPlayGame/free_to_play_game.dart';

abstract class FreeToPlayGamesRepository {

  Future<List<FreeToPlayGame>?> getGames();

}