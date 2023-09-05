import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/ExploreTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/ExploreTabViewModel.dart';
import 'package:flutter/material.dart';

class ExploreTabView extends StatefulWidget {
  const ExploreTabView({super.key});

  @override
  State<ExploreTabView> createState() => _ExploreTabViewState();
}

class _ExploreTabViewState extends BaseState<ExploreTabView ,ExploreTabViewModel> implements ExploreTabNavigator {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }

  @override
  ExploreTabViewModel initViewModel() {
    return ExploreTabViewModel();
  }
}
