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
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({super.key});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends BaseState<ProfileTabView , ProfileTabViewModel> implements ProfileTabNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel!.setButtonsData();
    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(height: 200,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel!.local!.theme , style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),),
                  const ThemeSwitch(),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel!.local!.language , style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),),
                  const LanguageSwitch(),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            CustomButton(button: viewModel!.buttonsData[0]),
            const SizedBox(height: 10,),
            CustomButton(button: viewModel!.buttonsData[1]),
            const SizedBox(height: 10,),
            CustomButton(button: viewModel!.buttonsData[2]),
            const SizedBox(height: 10,),
            CustomButton(button: viewModel!.buttonsData[3]),
          ],
        ),
        UserProfileDataWidget(
          user: viewModel!.appConfigProvider!.getUser()!,
          buttonTitle: viewModel!.local!.edit,
          buttonAction: viewModel!.goToEditProfileScreen,
          isEn: viewModel!.localProvider!.isEn(),
        ),
      ],
    );
  }

  @override
  ProfileTabViewModel initViewModel() {
    return ProfileTabViewModel(
      useCase: injectSignUserOutUseCase()
    );
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

}
