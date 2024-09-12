import 'package:core/Base/BaseState.dart';
import 'package:domain/UseCase/SignUserOutUseCase.dart';
import 'package:presentation/UI/About/AboutView.dart';
import 'package:presentation/UI/EditProfile/EditProfileView.dart';
import 'package:presentation/UI/Feedback/FeedbackView.dart';
import 'package:presentation/UI/History/HistoryView.dart';
import 'package:presentation/UI/Home/Tabs/Profile/ProfileTabNavigator.dart';
import 'package:presentation/UI/Home/Tabs/Profile/ProfileTabViewModel.dart';
import 'package:presentation/UI/Home/Tabs/Profile/Widgets/CustomButton.dart';
import 'package:presentation/UI/Home/Tabs/Profile/Widgets/UserProfileDataWidget.dart';
import 'package:presentation/UI/Login/LoginView.dart';
import 'package:presentation/UI/ResetPassword/ResetPasswordView.dart';
import 'package:presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({super.key});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState
    extends BaseState<ProfileTabView, ProfileTabViewModel>
    implements ProfileTabNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.setButtonsData();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Column(
        children: [
          UserProfileDataWidget(
            user: viewModel.appConfigProvider!.getUser()!,
            buttonTitle: viewModel.local!.edit,
            buttonAction: viewModel.goToEditProfileScreen,
            isEn: viewModel.localProvider!.isEn(),
          ),
          Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          viewModel.local!.theme,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const ThemeSwitch(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          viewModel.local!.language,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const LanguageSwitch(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomButton(button: viewModel.buttonsData[0]),
                  const SizedBox(height: 10,),
                  CustomButton(button: viewModel.buttonsData[1]),
                  const SizedBox(height: 10,),
                  CustomButton(button: viewModel.buttonsData[2]),
                  const SizedBox(height: 10,),
                  CustomButton(button: viewModel.buttonsData[3]),
                  const SizedBox(height: 10,),
                  CustomButton(button: viewModel.buttonsData[4]),
                ],
              ))
        ],
      ),
    );
  }

  @override
  ProfileTabViewModel initViewModel() {
    return ProfileTabViewModel(useCase: injectSignUserOutUseCase());
  }

  @override
  goToEditProfileScreen() {
    Navigator.pushNamed(context, EditProfileView.routeName);
  }

  @override
  goToHistoryScreen() {
    Navigator.pushNamed(context, HistoryView.routeName);
  }

  @override
  goToFeedbackScreen() {
    Navigator.pushNamed(context, FeedbackView.routeName);
  }

  @override
  goToAboutUsScreen() {
    Navigator.pushNamed(context, AboutView.routeName);
  }

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }

  @override
  goToResetPasswordScreen() {
    Navigator.pushNamed(context, ResetPasswordView.routeName);
  }
}