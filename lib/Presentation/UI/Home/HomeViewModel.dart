import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Presentation/UI/Home/HomeNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/ExploreTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Favorite/FavoriteTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabView.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  int currentIndex = 0;

  List<Widget> tabs = [
    const HomeTabView(),
    const ChatTabView(),
    const ExploreTabView(),
    const FavoriteTabView(),
    const ProfileTabView()
  ];

  // function to change the selected index to change the tab
  changeSelectedIndex(int selectedIndex){
      currentIndex = selectedIndex;
      notifyListeners();
  }

}