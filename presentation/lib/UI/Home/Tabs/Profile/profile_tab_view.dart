import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/sign_user_out_use_case.dart';
import 'package:presentation/UI/About/about_view.dart';
import 'package:presentation/UI/EditProfile/edit_profile_view.dart';
import 'package:presentation/UI/Feedback/feedback_view.dart';
import 'package:presentation/UI/History/history_view.dart';
import 'package:presentation/UI/Home/Tabs/Profile/profile_tab_navigator.dart';
import 'package:presentation/UI/Home/Tabs/Profile/profile_tab_view_model.dart';
import 'package:presentation/UI/Home/Tabs/Profile/Widgets/custom_button.dart';
import 'package:presentation/UI/Home/Tabs/Profile/Widgets/user_profile_data_widget.dart';
import 'package:presentation/UI/Login/login_view.dart';
import 'package:presentation/UI/ResetPassword/reset_password_view.dart';
import 'package:presentation/UI/Widgets/language_switch.dart';
import 'package:presentation/UI/Widgets/theme_switch.dart';
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