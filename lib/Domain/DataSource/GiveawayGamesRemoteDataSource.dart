import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGames.dart';

abstract class GiveawayGamesRemoteDataSource {
  Future<List<GiveawayGames>?> getAllGames();
}