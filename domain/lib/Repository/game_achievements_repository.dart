import 'package:domain/Models/Achievements/achievement.dart';

abstract class GameAchievementsRepository {

  Future<List<Achievement>?> getGameAchievements({required String id});
  Future<(String?, List<Achievement>?)> getAllAGameAchievements({required String id ,  required String pageNumber});

}