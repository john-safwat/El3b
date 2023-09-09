import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GivaawayList.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GiveawayGamesHoldWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomSearchBar.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});
  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends BaseState<HomeTabView, HomeTabViewModel> implements HomeTabNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.getGames();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<HomeTabViewModel>(
        builder: (context, value, child) {
          if (value.errorMessage != null) {
            return ErrorMessageWidget(
              errorMessage: value.errorMessage!,
              fixErrorFunction: viewModel!.getGames,
            );
          } else if (value.listGiveawayGames.isEmpty) {
            return Center(
                child: LoadingBouncingGrid.circle(
              backgroundColor: viewModel!.themeProvider!.isDark()
                  ? MyTheme.offWhite
                  : MyTheme.lightPurple,
            ));
          } else {
            return Stack(
              children: [
                ListView(
                  children: [
                    const SizedBox(height: 80,),
                    GiveawayList(
                      games: value.listGiveawayGames,
                      selectGame: value.selectGiveawayGame,
                      unselectGame: value.unselectGame,
                      urlLauncher: value.openURL,
                    ),
                    const SizedBox(height: 20,),
                    const ThemeSwitch(),
                    const SizedBox(height: 20,),
                    const LanguageSwitch()
                  ],
                ),
                const SafeArea(child: CustomSearchBarButton()),
                viewModel!.giveawayGameSelected ?GiveawayGamesHoldWidget(game: value.giveawaySelectedGames,) : const SizedBox()
              ],
            );
          }
        },
      ),
    );
  }

  @override
  HomeTabViewModel initViewModel() {
    return HomeTabViewModel(getAllGiveGamesUseCase: injectGetAllGiveGamesUseCase());
  }
}
