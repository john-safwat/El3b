import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGames.dart';

abstract class GiveawayGamesRepository {
  Future<List<GiveawayGames>?> getAllGames();
}