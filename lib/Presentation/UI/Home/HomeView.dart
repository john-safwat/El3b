import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/Home/HomeNavigator.dart';
import 'package:El3b/Presentation/UI/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

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
    debugPrint("this ew is john");

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder:(context, value, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: viewModel.tabs[viewModel.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value.currentIndex,

            items: [
              BottomNavigationBarItem(
                label: viewModel.local!.home,
                icon: const Icon(Bootstrap.house , size: 20,),
                activeIcon: const Icon(Bootstrap.house_fill , size: 20,)
              ),
              BottomNavigationBarItem(
                  label: viewModel.local!.chat,
                  icon: const Icon(Bootstrap.chat_left_text, size: 20,),
                  activeIcon: const Icon(Bootstrap.chat_left_text_fill, size: 20,)
              ),
              BottomNavigationBarItem(
                  label: viewModel.local!.explore,
                  icon: const Icon(Bootstrap.compass, size: 20,),
                  activeIcon: const Icon(Bootstrap.compass_fill, size: 20,),
              ),
              BottomNavigationBarItem(
                  label: viewModel.local!.favorite,
                  icon:const Icon(Bootstrap.heart, size: 20,),
                  activeIcon:const Icon(Bootstrap.heart_fill, size: 20,),
              ),
              BottomNavigationBarItem(
                  label: viewModel.local!.home,
                  icon:const Icon(Bootstrap.person, size: 20,),
                  activeIcon:const Icon(Bootstrap.person_fill, size: 20,),
              ),
            ],
            onTap: (value) {
              viewModel.changeSelectedIndex(value);
            },
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
