import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/Widgets/UserProfileDataWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({super.key});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends BaseState<ProfileTabView , ProfileTabViewModel> implements ProfileTabNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        UserProfileDataWidget(
          user: viewModel!.appConfigProvider!.getUser()!,
          buttonTitle: viewModel!.local!.edit,
          buttonAction: (){},
          isEn: viewModel!.localProvider!.isEn(),
        ),
        ThemeSwitch(),
        LanguageSwitch()
      ],
    );
  }

  @override
  ProfileTabViewModel initViewModel() {
    return ProfileTabViewModel();
  }
}
