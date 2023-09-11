import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';

abstract class GiveawayGamesRepository {
  Future<List<GiveawayGame>?> getAllGames();
}