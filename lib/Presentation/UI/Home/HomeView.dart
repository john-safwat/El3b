import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Home/HomeNavigator.dart';
import 'package:El3b/Presentation/UI/Home/HomeViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          body: Column(
            children: [
              Expanded(
                child: viewModel!.tabs[viewModel!.currentIndex]
              )
            ],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: SalomonBottomBar(
              items: [
                SalomonBottomBarItem(
                  title: const Text("Home"),
                  icon:const Icon(Bootstrap.house),
                  activeIcon:const Icon(Bootstrap.house_fill)
                ),
                SalomonBottomBarItem(
                  title: const Text("Chat"),
                  icon:const Icon(Bootstrap.chat_left_text),
                  activeIcon:const Icon(Bootstrap.chat_left_text_fill)
                ),
                SalomonBottomBarItem(
                  title:const Text("Explore"),
                  icon:const Icon(Bootstrap.compass),
                  activeIcon:const Icon(Bootstrap.compass_fill),
                ),
                SalomonBottomBarItem(
                  title:const Text("Favorite"),
                  icon:const Icon(Bootstrap.heart),
                  activeIcon:const Icon(Bootstrap.heart_fill),
                ),
                SalomonBottomBarItem(
                  title:const Text("Profile"),
                  icon:const Icon(Bootstrap.person),
                  activeIcon:const Icon(Bootstrap.person_fill),
                ),
              ],
              currentIndex: viewModel!.currentIndex,
              onTap: (selectedIndex) => viewModel!.changeSelectedIndex(selectedIndex),
              backgroundColor: MyTheme.lightPurple,
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
