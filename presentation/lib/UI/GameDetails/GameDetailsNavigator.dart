import 'package:core/Base/BaseNavigator.dart';
import 'package:domain/Models/Developers/Developers.dart';

abstract class GameDetailsNavigator extends BaseNavigator {

  goToDeveloperProfileScreen({required Developer developer});
  goToAchievementsListScreen({required String gameId});

}