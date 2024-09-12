import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/add_game_to_history_use_case.dart';
import 'package:domain/UseCase/get_games_by_genre_use_case.dart';
import 'package:presentation/UI/GamesList/GamesListNavigator.dart';
import 'package:presentation/UI/GamesList/GamesListViewModel.dart';
import 'package:presentation/UI/Widgets/CustomSearchBarButton.dart';
import 'package:presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:presentation/UI/Widgets/GameHoldWidget.dart';
import 'package:presentation/UI/Widgets/GameWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GamesListView extends StatefulWidget {
  static const String routeName = "GamesListView";

  const GamesListView({super.key});

  @override
  State<GamesListView> createState() => _GamesListViewState();
}

class _GamesListViewState extends BaseState<GamesListView, GamesListViewModel>
    implements GamesListNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (viewModel.genre.isEmpty) {
      viewModel.genre = ModalRoute.of(context)?.settings.arguments as String;
      viewModel.getGames();
    }
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 70,
            titleSpacing: 10,
            centerTitle: true,
            title: CustomSearchBarButton(
              navigation: viewModel.goToSearchScreen,
            ),
          ),
          body: Consumer<GamesListViewModel>(
            builder: (context, value, child) {
              if (value.errorMessage != null) {
                return ErrorMessageWidget(
                  errorMessage: value.errorMessage ?? "",
                  fixErrorFunction: value.getGames,
                );
              } else if (value.games.isEmpty) {
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
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (index < value.games.length) {
                                return GameWidget(
                                  tag: value.games[index].id.toString(),
                                  game: value.games[index],
                                  selectGame: value.selectRAWGGame,
                                  unselectGame: value.unselectRAWGGame,
                                  editWishListState:
                                      value.editGameWishListState,
                                  goToGameDetailsScreen:
                                      value.goToGameDetailsScreen,
                                  addGameToHistory: value.addGameToHistory,
                                );
                              } else if (value.errorMessage != null) {
                                return ErrorMessageWidget(
                                  errorMessage: value.errorMessage!,
                                  fixErrorFunction: value.getGames,
                                );
                              } else {
                                value.getGames();
                                return Padding(
                                  padding: const EdgeInsets.all(30.0),
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
                              }
                            },
                            itemCount: value.count > value.games.length
                                ? value.games.length + 1
                                : value.games.length,
                          ))
                        ],
                      ),
                    ),
                    value.rawgGameSelected
                        ? GameHoldWidget(
                            tag: value.rawgGameSelectedGame.id.toString(),
                            game: value.rawgGameSelectedGame)
                        : const SizedBox()
                  ],
                );
              }
            },
          )),
    );
  }

  @override
  GamesListViewModel initViewModel() {
    return GamesListViewModel(
        getGamesByGenreUseCase: injectGetGamesByGenreUseCase(),
        addGameToHistoryUseCase: injectAddGameToHistoryUseCase());
  }
}
