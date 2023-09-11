import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';

abstract class GiveawayGamesRemoteDataSource {
  Future<List<GiveawayGame>?> getAllGames();
}