import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetFreeToPlayGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetRAWGGeneralGamesUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/FreeToPlayGamesHoldWidget.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/FreeToPlayGamesList.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GivaawayGamesList.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GiveawayGamesHoldWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomSearchBar.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameHoldWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
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
              return const Center(child:CircularProgressIndicator());
            } else {
              return Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 110,),
                        GiveawayGamesList(
                          games: value.listGiveawayGames,
                          selectGame: value.selectGiveawayGame,
                          unselectGame: value.unselectGiveawayGame,
                          urlLauncher: value.openURL,
                        ),
                        const SizedBox(height:30,),
                        FreeToPlayGamesList(
                            games: value.listFreeToPLayGames,
                            selectGame: value.selectFreeToPlayGame,
                            unselectGame: value.unselectFreeToPlayGame,
                            urlLauncher: value.openURL
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            Text(
                              value.local!.recommendedGames,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        for(int i = 0 ; i < value.listRAWGGames.length ; i++)
                          GameWidget(
                              game: value.listRAWGGames[i],
                              selectGame: value.selectRAWGGame,
                              unselectGame: value.unselectRAWGGame
                          ),

                        const ThemeSwitch(),
                        const SizedBox(height: 20,),
                        const LanguageSwitch(),
                        const SizedBox(height: 105,),
                      ],
                    ),
                  ),
                  const SafeArea(child: CustomSearchBarButton()),
                  viewModel!.giveawayGameSelected ?GiveawayGamesHoldWidget(game: value.giveawaySelectedGame,) : const SizedBox(),
                  viewModel!.freeToPlayGameSelected ?FreeToPlayGamesHoldWidget(game: value.freeToPlayGameSelectedGame,) : const SizedBox(),
                  viewModel!.rawgGameSelected ?GameHoldWidget( game : value.rawgGameSelectedGame,) : const SizedBox()
                ],
              );
            }
          },
        ),
    );
  }

  @override
  HomeTabViewModel initViewModel() {
    return HomeTabViewModel(
      getAllGiveGamesUseCase: injectGetAllGiveGamesUseCase(),
      getFreeToPlayGamesUseCase: injectGetFreeToPlayGamesUseCase(),
      getRAWGGeneralGamesUseCase: injectGetRAWGGeneralGamesUseCase()
    );
  }
}
