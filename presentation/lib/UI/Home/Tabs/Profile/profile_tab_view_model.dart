import 'package:core/Base/base_view_model.dart';
import 'package:domain/UseCase/sign_user_out_use_case.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:presentation/Models/button.dart';
import 'package:presentation/UI/Home/Tabs/Profile/profile_tab_navigator.dart';

class ProfileTabViewModel extends BaseViewModel<ProfileTabNavigator> {
  SignUserOutUseCase useCase;

  ProfileTabViewModel({required this.useCase});

  late List<Button> buttonsData;

  // function to set the buttons data
  setButtonsData() {
    buttonsData = [
      Button(
          id: 1,
          icon: EvaIcons.lock,
          title: local!.changePassword,
          onClickListener: goToResetPasswordScreen,
          color: const Color(0xFFF9A541)),
      Button(
          id: 1,
          icon: EvaIcons.clock_outline,
          title: local!.history,
          onClickListener: goToHistoryScreen,
          color: const Color(0xff007aff)),
      Button(
          id: 2,
          icon: EvaIcons.smiling_face,
          title: local!.feedback,
          onClickListener: goToFeedbackScreen,
          color: const Color(0xff4cd964)),
      Button(
          id: 3,
          icon: EvaIcons.info_outline,
          title: local!.aboutUs,
          onClickListener: goToAboutUsScreen,
          color: const Color(0xff34aadc)),
      Button(
          id: 4,
          icon: EvaIcons.log_out,
          title: local!.signOut,
          onClickListener: onSignOutPress,
          color: const Color(0xFFF73645))
    ];
  }

  // function to navigate to Edit Profile Screen
  goToEditProfileScreen() {
    navigator!.goToEditProfileScreen();
  }

  // function to go to History Screen
  goToHistoryScreen() {
    navigator!.goToHistoryScreen();
  }

  // function to go to feedback screen
  goToFeedbackScreen() {
    navigator!.goToFeedbackScreen();
  }

  // function to to about us Screen
  goToAboutUsScreen() {
    navigator!.goToAboutUsScreen();
  }

  goToResetPasswordScreen() {
    navigator!.goToResetPasswordScreen();
  }

  // Function to sign out user
  onSignOutPress() {
    navigator!.showQuestionMessage(
        message: local!.areYouSureToExit,
        negativeActionTitle: local!.cancel,
        posActionTitle: local!.ok,
        posAction: signOut);
  }

  signOut() async {
    navigator!.showLoading(message: local!.loading);
    try {
      await useCase.invoke();
      navigator!.goBack();
      navigator!.goToLoginScreen();
    } catch (e) {
      navigator!.goBack();
      navigator!.showFailMessage(
        message: handleExceptions(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }
  }
}
