import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';

abstract class GiveawayGamesRepository {
  Future<List<GiveawayGame>?> getAllGames();
  Future<List<GiveawayGame>?> getDataFromServer();
}