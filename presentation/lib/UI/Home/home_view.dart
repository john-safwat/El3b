
import 'package:core/Base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:presentation/UI/Home/HomeNavigator.dart';
import 'package:presentation/UI/Home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {

  static const String routeName = "HomeScreenView";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView , HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async{
          viewModel.onScreenPop(didPop);},
        child: Consumer<HomeViewModel>(
          builder:(context, value, child) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: viewModel.tabs[viewModel.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: value.currentIndex,

              items: [
                BottomNavigationBarItem(
                    label: viewModel.local!.home,
                    icon: const Icon(EvaIcons.home_outline , size: 20,),
                    activeIcon: const Icon(EvaIcons.home , size: 20,)
                ),
                BottomNavigationBarItem(
                    label: viewModel.local!.chat,
                    icon: const Icon(EvaIcons.message_square_outline, size: 20,),
                    activeIcon: const Icon(EvaIcons.message_square, size: 20,)
                ),
                BottomNavigationBarItem(
                  label: viewModel.local!.explore,
                  icon: const Icon(EvaIcons.grid_outline, size: 20,),
                  activeIcon: const Icon(EvaIcons.grid, size: 20,),
                ),
                BottomNavigationBarItem(
                  label: viewModel.local!.favorite,
                  icon:const Icon(EvaIcons.heart_outline, size: 20,),
                  activeIcon:const Icon(EvaIcons.heart, size: 20,),
                ),
                BottomNavigationBarItem(
                  label: viewModel.local!.home,
                  icon:const Icon(EvaIcons.person_outline, size: 20,),
                  activeIcon:const Icon(EvaIcons.person, size: 20,),
                ),
              ],
              onTap: (value) {
                viewModel.changeSelectedIndex(value);
              },
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
