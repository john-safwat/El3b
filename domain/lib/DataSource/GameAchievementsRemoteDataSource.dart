
import 'package:domain/Models/Achievements/Achievement.dart';

abstract class GameAchievementsRemoteDataSource {

  Future<List<Achievement>?> getGameAchievements({required String id});
  Future<(String?, List<Achievement>?)> getAllAGameAchievements({required String id ,  required String pageNumber});
}