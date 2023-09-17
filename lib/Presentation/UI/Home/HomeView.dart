import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Home/HomeNavigator.dart';
import 'package:El3b/Presentation/UI/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeView extends StatefulWidget {

  static const String routeName = "HomeScreenView";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView , HomeViewModel> implements HomeNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<HomeViewModel>(
        builder:(context, value, child) => Scaffold(
          extendBody: true,
          body: viewModel!.tabs[viewModel!.currentIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: SalomonBottomBar(
              items: [
                SalomonBottomBarItem(
                  title: Text(viewModel!.local!.home),
                  icon:const Icon(Bootstrap.house),
                  activeIcon:const Icon(Bootstrap.house_fill)
                ),
                SalomonBottomBarItem(
                  title: Text(viewModel!.local!.chat),
                  icon:const Icon(Bootstrap.chat_left_text),
                  activeIcon:const Icon(Bootstrap.chat_left_text_fill)
                ),
                SalomonBottomBarItem(
                  title: Text(viewModel!.local!.explore),
                  icon:const Icon(Bootstrap.compass),
                  activeIcon:const Icon(Bootstrap.compass_fill),
                ),
                SalomonBottomBarItem(
                  title: Text(viewModel!.local!.favorite),
                  icon:const Icon(Bootstrap.heart),
                  activeIcon:const Icon(Bootstrap.heart_fill),
                ),
                SalomonBottomBarItem(
                  title: Text(viewModel!.local!.profile),
                  icon:const Icon(Bootstrap.person),
                  activeIcon:const Icon(Bootstrap.person_fill),
                ),
              ],
              currentIndex: viewModel!.currentIndex,
              onTap: (selectedIndex) => viewModel!.changeSelectedIndex(selectedIndex),
              backgroundColor: viewModel!.themeProvider!.isDark()?MyTheme.purple : MyTheme.lightPurple,
              margin: const EdgeInsets.all(10),
              itemShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              selectedItemColor: MyTheme.offWhite,
              selectedColorOpacity: 0.2,
              unselectedItemColor: MyTheme.darkPurple,
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
