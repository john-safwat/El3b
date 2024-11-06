import 'package:core/Base/base_state.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/UseCase/add_game_to_history_use_case.dart';
import 'package:domain/UseCase/get_all_give_games_use_case.dart';
import 'package:domain/UseCase/get_free_to_play_games_use_case.dart';
import 'package:domain/UseCase/get_giveaway_games_from_server_use_case.dart';
import 'package:domain/UseCase/get_rawg_general_games_use_case.dart';
import 'package:presentation/UI/Home/Tabs/Home/home_tab_view_model.dart';
import 'package:presentation/UI/Home/Tabs/Home/Widgets/free_to_play_games_hold_widget.dart';
import 'package:presentation/UI/Home/Tabs/Home/Widgets/free_to_play_games_list.dart';
import 'package:presentation/UI/Home/Tabs/Home/Widgets/giveaway_games_list.dart';
import 'package:presentation/UI/Home/Tabs/Home/Widgets/giveaway_games_hold_widget.dart';
import 'package:presentation/UI/Widgets/custom_search_bar_button.dart';
import 'package:presentation/UI/Widgets/error_message_widget.dart';
import 'package:presentation/UI/Widgets/game_hold_widget.dart';
import 'package:presentation/UI/Widgets/game_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends BaseState<HomeTabView, HomeTabViewModel> {
  @override
  void initState() {
    super.initState();
    Future.wait([viewModel.getGames(), viewModel.getGeneralGames()]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 70,
          titleSpacing: 10,
          centerTitle: true,
          leadingWidth: 0,
          title: CustomSearchBarButton(
            navigation: viewModel.goToSearchScreen,
          ),
        ),
        body: RefreshIndicator(
          color: MyTheme.lightPurple,
          onRefresh: viewModel.loadNewGame,
          edgeOffset: 100,
          child: Consumer<HomeTabViewModel>(
            builder: (context, value, child) {
              if (value.errorMessage != null) {
                return ErrorMessageWidget(
                  errorMessage: value.errorMessage!,
                  fixErrorFunction: () {
                    viewModel.getGames();
                    viewModel.getGeneralGames();
                  },
                );
              } else if (value.listGiveawayGames.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: value.themeProvider!.isDark()
                          ? Lottie.asset("Assets/Animations/loading2.json",
                              width: 150, height: 120)
                          : Lottie.asset("Assets/Animations/loading3.json",
                              width: 300, height: 300),
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            GiveawayGamesList(
                              games: value.listGiveawayGames,
                              selectGame: value.selectGiveawayGame,
                              unselectGame: value.unselectGiveawayGame,
                              urlLauncher: value.openURL,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FreeToPlayGamesList(
                                games: value.listFreeToPLayGames,
                                selectGame: value.selectFreeToPlayGame,
                                unselectGame: value.unselectFreeToPlayGame,
                                urlLauncher: value.openURL),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  value.local!.recommendedGames,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            ),
                            Consumer<HomeTabViewModel>(
                              builder: (context, value, child) {
                                if (value.rawgErrorMessage != null) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Lottie.asset(
                                                "Assets/Animations/error.json",
                                                width: 120,
                                                fit: BoxFit.cover)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          viewModel.local!.someThingWentWrong,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              value.getGeneralGames();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                              child:
                                                  Text(value.local!.tryAgain),
                                            ))
                                      ],
                                    ),
                                  );
                                } else if (value.listRAWGGames.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(80.0),
                                    child: value.themeProvider!.isDark()
                                        ? Lottie.asset(
                                            "Assets/Animations/loading2.json",
                                            width: 150,
                                            height: 120)
                                        : Lottie.asset(
                                            "Assets/Animations/loading3.json",
                                            width: 300,
                                            height: 300),
                                  );
                                } else {
                                  return Column(
                                    children: value.listRAWGGames
                                        .map(
                                          (e) => GameWidget(
                                              game: e,
                                              selectGame: value.selectRAWGGame,
                                              unselectGame:
                                                  value.unselectRAWGGame,
                                              editWishListState:
                                                  value.editGameWishListState,
                                              goToGameDetailsScreen:
                                                  value.goToGameDetailsScreen,
                                              addGameToHistory:
                                                  value.addGameToHistory,
                                              tag: e.id.toString()),
                                        )
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    viewModel.giveawayGameSelected
                        ? GiveawayGamesHoldWidget(
                            game: value.giveawaySelectedGame,
                          )
                        : viewModel.freeToPlayGameSelected
                            ? FreeToPlayGamesHoldWidget(
                                game: value.freeToPlayGameSelectedGame,
                              )
                            : viewModel.rawgGameSelected
                                ? GameHoldWidget(
                                    game: value.rawgGameSelectedGame,
                                    tag: value.rawgGameSelectedGame.id
                                        .toString(),
                                  )
                                : const SizedBox()
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  HomeTabViewModel initViewModel() {
    return HomeTabViewModel(
        getAllGiveGamesUseCase: injectGetAllGiveGamesUseCase(),
        getFreeToPlayGamesUseCase: injectGetFreeToPlayGamesUseCase(),
        getRAWGGeneralGamesUseCase: injectGetRAWGGeneralGamesUseCase(),
        gamesFromServerUseCase: injectGetGiveawayGamesFromServerUseCase(),
        addGameToHistoryUseCase: injectAddGameToHistoryUseCase());
  }
}
