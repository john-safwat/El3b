import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGamesByGenreUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGenresUseCase.dart';
import 'package:El3b/Presentation/UI/GamesSearch/GameSearchView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/ExploreTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/ExploreTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/Widgets/TabButton.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomSearchBarButton.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameHoldWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ExploreTabView extends StatefulWidget {
  const ExploreTabView({super.key});

  @override
  State<ExploreTabView> createState() => _ExploreTabViewState();
}

class _ExploreTabViewState
    extends BaseState<ExploreTabView, ExploreTabViewModel>
    implements ExploreTabNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      builder: (context, child) => Consumer<ExploreTabViewModel>(
        builder: (context, value, child) {
          if (value.errorMessage != null) {
            return ErrorMessageWidget(
                errorMessage: value.errorMessage!,
                fixErrorFunction: value.getGenres);
          } else if (value.genres.isEmpty) {
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
            return DefaultTabController(
              length: value.genres.length,
              initialIndex: 0,
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    toolbarHeight: 85,
                    titleSpacing: 10,
                    centerTitle: true,
                    leadingWidth: 0,
                    title: CustomSearchBarButton(
                      navigation: viewModel!.goToSearchScreen,
                    ),
                    bottom: TabBar(
                      physics: const BouncingScrollPhysics(),
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      indicator: const BoxDecoration(),
                      labelPadding: const EdgeInsets.only(top: 5, left: 10),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      tabs: value.genres
                          .map((e) => TabButton(
                              genre: e,
                              isSelected:
                                  value.genres.indexOf(e) == value.selectedTab))
                          .toList(),
                      onTap: (index) {
                        value.changeIndex(index);
                      },
                    ),
                  ),
                  body: Consumer<ExploreTabViewModel>(
                    builder: (context, value, child) {
                      if (value.gamesErrorMessage != null) {
                        return ErrorMessageWidget(
                          errorMessage: value.errorMessage??"",
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
                                  ? Lottie.asset(
                                      "Assets/Animations/loading2.json",
                                      width: 150,
                                      height: 120)
                                  : Lottie.asset(
                                      "Assets/Animations/loading3.json",
                                      width: 300,
                                      height: 300),
                            ),
                          ],
                        );
                      } else {
                        return Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    if (index < value.games.length) {
                                      return GameWidget(
                                        game: value.games[index],
                                        selectGame: value.selectRAWGGame,
                                        unselectGame: value.unselectRAWGGame,
                                        editWishListState: value.editGameWishListState,
                                      );
                                    } else if (value.gamesErrorMessage != null) {
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
                            value.rawgGameSelected?GameHoldWidget(game: value.rawgGameSelectedGame) : const SizedBox()
                          ],
                        );
                      }
                    },
                  )),
            );
          }
        },
      ),
    );
  }

  @override
  ExploreTabViewModel initViewModel() {
    return ExploreTabViewModel(
        getGenresUseCase: injectGetGenresUseCase(),
        getGamesByGenreUseCase: injectGetGamesByGenreUseCase(),
        addGameToWishListUseCase: injectAddGameToWishListUseCase(),
        deleteGameFromWishListUseCase: injectDeleteGameFromWishListUseCase());
  }

  @override
  goToSearchScreen() {
    Navigator.pushNamed(context, GameSearchView.routeName);
  }
}
