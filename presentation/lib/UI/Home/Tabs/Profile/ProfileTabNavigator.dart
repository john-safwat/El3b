import 'package:core/Base/BaseNavigator.dart';

abstract class ProfileTabNavigator extends BaseNavigator {
  goToEditProfileScreen();
  goToHistoryScreen();
  goToFeedbackScreen();
  goToAboutUsScreen();
  goToLoginScreen();
  goToResetPasswordScreen();
}