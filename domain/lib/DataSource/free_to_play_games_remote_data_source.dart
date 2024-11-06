import 'package:domain/Models/Games/FreeToPlayGame/free_to_play_game.dart';

abstract class FreeToPlayGamesRemoteDataSource {

  Future<List<FreeToPlayGame>?> getGames();

}