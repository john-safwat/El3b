import 'package:core/Base/base_navigator.dart';
import 'package:domain/Models/Developers/developers.dart';

abstract class GameDetailsNavigator extends BaseNavigator {

  goToDeveloperProfileScreen({required Developer developer});
  goToAchievementsListScreen({required String gameId});

}