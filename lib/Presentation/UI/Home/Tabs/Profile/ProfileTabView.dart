import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabViewModel.dart';
import 'package:flutter/material.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({super.key});

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends BaseState<ProfileTabView , ProfileTabViewModel> implements ProfileTabNavigator {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
    );
  }

  @override
  ProfileTabViewModel initViewModel() {
    return ProfileTabViewModel();
  }
}
