import 'package:El3b/Domain/Models/Achievements/Achievement.dart';

abstract class GameAchievementsRepository {

  Future<List<Achievement>?> getGameAchievements({required String id});

}