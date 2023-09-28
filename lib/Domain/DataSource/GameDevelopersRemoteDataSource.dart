import 'package:El3b/Domain/Models/Developers/Developers.dart';

abstract class GameDevelopersRemoteDataSource {

  Future<List<Developers>?> getGameDevelopers({required String id});

}