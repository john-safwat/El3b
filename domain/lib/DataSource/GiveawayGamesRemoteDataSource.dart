import 'package:domain/Models/Games/GiveawayGames/GiveawayGame.dart';

abstract class GiveawayGamesRemoteDataSource {
  Future<List<GiveawayGame>?> getAllGames();
}