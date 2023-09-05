import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Favorite/FavoriteTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Favorite/FavoriteTabViewModel.dart';
import 'package:flutter/material.dart';

class FavoriteTabView extends StatefulWidget {
  const FavoriteTabView({super.key});

  @override
  State<FavoriteTabView> createState() => _FavoriteTabViewState();
}

class _FavoriteTabViewState extends BaseState<FavoriteTabView , FavoriteTabViewModel> implements FavoriteTabNavigator {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellowAccent,);
  }

  @override
  FavoriteTabViewModel initViewModel() {
    return FavoriteTabViewModel();
  }
}
