import 'package:domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';

abstract class FreeToPlayGamesRemoteDataSource {

  Future<List<FreeToPlayGame>?> getGames();

}