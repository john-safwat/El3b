import 'package:core/Base/BaseViewModel.dart';
import 'package:presentation/UI/Home/HomeNavigator.dart';
import 'package:presentation/UI/Home/Tabs/Chat/ChatTabView.dart';
import 'package:presentation/UI/Home/Tabs/Explore/ExploreTabView.dart';
import 'package:presentation/UI/Home/Tabs/Favorite/FavoriteTabView.dart';
import 'package:presentation/UI/Home/Tabs/Home/HomeTabView.dart';
import 'package:presentation/UI/Home/Tabs/Profile/ProfileTabView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  int currentIndex = 0;

  List<int> selectedIndexes = [];
  List<Widget> tabs = [
    const HomeTabView(),
    const ChatTabView(),
    const ExploreTabView(),
    const FavoriteTabView(),
    const ProfileTabView()
  ];

  // function to change the selected index to change the tab
  changeSelectedIndex(int selectedIndex) {
    selectedIndexes.add(currentIndex);
    currentIndex = selectedIndex;
    notifyListeners();
  }

  void onScreenPop(bool didPop) {
    if (selectedIndexes.isNotEmpty) {
      currentIndex = selectedIndexes[selectedIndexes.length - 1];
      selectedIndexes.removeAt(selectedIndexes.length - 1);
    } else {
      navigator!.showQuestionMessage(
          message: local!.areYouSureToExit,
          negativeActionTitle: local!.ok,
          negativeAction:
              () {
            SystemNavigator.pop();
          },
          posActionTitle: local!.cancel
      );
    }
    notifyListeners();
  }

}