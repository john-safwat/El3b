import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';

abstract class GiveawayGamesRemoteDataSource {
  Future<List<GiveawayGame>?> getAllGames();
}