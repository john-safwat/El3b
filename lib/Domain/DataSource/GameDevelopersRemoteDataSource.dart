import 'package:El3b/Domain/Models/Developers/Developers.dart';

abstract class GameDevelopersRemoteDataSource {

  Future<List<Developer>?> getGameDevelopers({required String id});
  Future<Developer?> getGameDeveloperDetails({required String id});

}