import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/SignUserOutUseCase.dart';
import 'package:El3b/Presentation/UI/About/AboutView.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileView.dart';
import 'package:El3b/Presentation/UI/Feedback/FeedbackView.dart';
import 'package:El3b/Presentation/UI/History/HistoryView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/Widgets/CustomButton.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/Widgets/UserProfileDataWidget.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:El3b/Presentation/UI/ResetPassword/ResetPasswordView.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child: CustomButton(button: viewModel.buttonsData[0])),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: CustomButton(button: viewModel.buttonsData[1])),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(child: CustomButton(button: viewModel.buttonsData[2])),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: CustomButton(button: viewModel.buttonsData[3])),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => viewModel.buttonsData[4].onClickListener(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                      decoration: BoxDecoration(
                        color: viewModel.buttonsData[4].color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              viewModel.buttonsData[4].icon,
                              size: 25,
                              color: MyTheme.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            viewModel.buttonsData[4].title,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const Expanded(child: SizedBox()),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  )
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