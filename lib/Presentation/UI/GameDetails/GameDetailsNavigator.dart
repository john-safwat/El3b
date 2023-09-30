import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';

abstract class GameDetailsNavigator extends BaseNavigator {

  goToDeveloperProfileScreen({required Developer developer});

}