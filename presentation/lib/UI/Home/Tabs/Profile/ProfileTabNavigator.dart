import 'package:core/Base/base_navigator.dart';

abstract class ProfileTabNavigator extends BaseNavigator {
  goToEditProfileScreen();
  goToHistoryScreen();
  goToFeedbackScreen();
  goToAboutUsScreen();
  goToLoginScreen();
  goToResetPasswordScreen();
}