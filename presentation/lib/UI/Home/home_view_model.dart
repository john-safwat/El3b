import 'package:core/Base/base_view_model.dart';
import 'package:presentation/UI/Home/Tabs/Chat/chat_tab_view.dart';
import 'package:presentation/UI/Home/Tabs/Explore/explore_tab_view.dart';
import 'package:presentation/UI/Home/Tabs/Favorite/favorite_tab_view.dart';
import 'package:presentation/UI/Home/Tabs/Home/home_tab_view.dart';
import 'package:presentation/UI/Home/Tabs/Profile/profile_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeViewModel extends BaseViewModel{
  int currentIndex = 0;

  PageController pageController = PageController();
  List<int> selectedIndexes = [];
  List<Widget> tabs = [
    const HomeTabView(),
    const ChatTabView(),
    const ExploreTabView(),
    const FavoriteTabView(),
    const ProfileTabView()
  ];


  initPageView(){
    pageController.addListener(changeSelectedIndexOnScroll);
  }
  // function to change the selected index to change the tab
  changeSelectedIndex(int selectedIndex) {
    selectedIndexes.add(currentIndex);
    currentIndex = selectedIndex;
    pageController.animateToPage(currentIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
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


  void changeSelectedIndexOnScroll() {
    selectedIndexes.add(currentIndex);
    currentIndex = pageController.page?.toInt()??0;
    notifyListeners();
  }
}