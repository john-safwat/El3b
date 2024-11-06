import 'package:domain/Models/Developers/developers.dart';

abstract class GameDevelopersRepository {

  Future<List<Developer>?> getGameDevelopers({required String id});
  Future<Developer?> getGameDeveloperDetails({required String id});
}