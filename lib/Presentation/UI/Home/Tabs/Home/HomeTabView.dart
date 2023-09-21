import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetFreeToPlayGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetGiveawayGamesFromServerUseCase.dart';
import 'package:El3b/Domain/UseCase/GetRAWGGeneralGamesUseCase.dart';
import 'package:El3b/Presentation/UI/GamesSearch/GameSearchView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/FreeToPlayGamesHoldWidget.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/FreeToPlayGamesList.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GiveawayGamesList.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GiveawayGamesHoldWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomSearchBarButton.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameHoldWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});
  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends BaseState<HomeTabView, HomeTabViewModel>
    implements HomeTabNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.getGames();
    viewModel!.getGeneralGames();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 85,
          titleSpacing: 10,
          centerTitle: true,
          leadingWidth: 0,
          title: CustomSearchBarButton(navigation: viewModel!.goToSearchScreen,),
        ),
        body: RefreshIndicator(
          color: MyTheme.lightPurple,
          onRefresh: viewModel!.loadNewGame,
          child: Consumer<HomeTabViewModel>(
            builder: (context, value, child) {
              if (value.errorMessage != null) {
                return ErrorMessageWidget(
                  errorMessage: value.errorMessage!,
                  fixErrorFunction: (){
                    viewModel!.getGames();
                    viewModel!.getGeneralGames();
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
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            ),
                            Consumer<HomeTabViewModel>(
                                builder: (context, value, child) {
                                  if(value.rawgErrorMessage != null){
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Center(child: Lottie.asset("Assets/Animations/error.json" ,width: 120 ,fit: BoxFit.cover )),
                                          const SizedBox(height: 20,),
                                          Text(
                                            viewModel!.local!.someThingWentWrong,
                                            style: Theme.of(context).textTheme.displayMedium,
                                          ),
                                          const SizedBox(height: 20,),
                                          ElevatedButton(
                                            onPressed: (){
                                              value.getGeneralGames();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
                                              child: Text(value.local!.tryAgain),
                                            )
                                          )
                                        ],
                                      ),
                                    );
                                  }else if (value.listRAWGGames.isEmpty){
                                    return  Padding(
                                      padding: const EdgeInsets.all(80.0),
                                      child: value.themeProvider!.isDark()
                                        ? Lottie.asset("Assets/Animations/loading2.json",
                                        width: 150, height: 120)
                                        : Lottie.asset("Assets/Animations/loading3.json",
                                        width: 300, height: 300),
                                    );
                                  }else {
                                    return Column(
                                      children: value.listRAWGGames.map((e) =>  GameWidget(
                                        game: e,
                                        selectGame: value.selectRAWGGame,
                                        unselectGame: value.unselectRAWGGame,
                                        editWishListState: value.editGameWishListState,
                                      ),).toList(),
                                    );
                                  }
                                },
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    viewModel!.giveawayGameSelected
                        ? GiveawayGamesHoldWidget(
                            game: value.giveawaySelectedGame,
                          )
                        : viewModel!.freeToPlayGameSelected
                            ? FreeToPlayGamesHoldWidget(
                                game: value.freeToPlayGameSelectedGame,
                              )
                            : viewModel!.rawgGameSelected
                                ? GameHoldWidget(
                                    game: value.rawgGameSelectedGame,
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
        addGameToWishListUseCase: injectAddGameToWishListUseCase(),
        deleteGameFromWishListUseCase: injectDeleteGameFromWishListUseCase(),
        gamesFromServerUseCase: injectGetGiveawayGamesFromServerUseCase(),
    );
  }

  @override
  goToSearchScreen() {
    Navigator.pushNamed(context, GameSearchView.routeName);
  }
}
