import 'package:domain/Models/Games/GiveawayGames/GiveawayGame.dart';

abstract class GiveawayGamesRepository {
  Future<List<GiveawayGame>?> getAllGames();
  Future<List<GiveawayGame>?> getDataFromServer();
}