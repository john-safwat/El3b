import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';

abstract class FreeToPlayGamesRemoteDataSource {

  Future<List<FreeToPlayGame>?> getGames();

}