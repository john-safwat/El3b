import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Presentation/UI/Home/HomeNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/ExploreTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Favorite/FavoriteTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabView.dart';
import 'package:flutter/cupertino.dart';
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