import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:domain/UseCase/GetGamesForWishListUseCase.dart';
import 'package:presentation/UI/Home/Tabs/Favorite/FavoriteTabNavigator.dart';
import 'package:presentation/UI/Home/Tabs/Favorite/FavoriteTabViewModel.dart';
import 'package:presentation/UI/Widgets/CustomSearchBar.dart';
import 'package:presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:presentation/UI/Widgets/GameHoldWidget.dart';
import 'package:presentation/UI/Widgets/GameWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoriteTabView extends StatefulWidget {
  const FavoriteTabView({super.key});

  @override
  State<FavoriteTabView> createState() => _FavoriteTabViewState();
}

class _FavoriteTabViewState
    extends BaseState<FavoriteTabView, FavoriteTabViewModel>
    implements FavoriteTabNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 70,
          title: CustomSearchBar(
            label: viewModel.local!.whatAreYouSearchingFor +
                viewModel.appConfigProvider!
                    .getUser()!
                    .displayName!
                    .split(" ")[0],
            onChangeFunction: viewModel.search,
          ),
          titleSpacing: 10,
        ),
        body: Consumer<FavoriteTabViewModel>(
          builder: (context, value, child) {
            if (value.errorMessage != null) {
              return ErrorMessageWidget(
                  errorMessage: value.errorMessage!,
                  fixErrorFunction: value.loadData);
            } else if (value.games.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(),
                  Lottie.asset("Assets/Animations/empty.json",
                      height: MediaQuery.sizeOf(context).height * 0.5),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    value.local!.noGamesInWishList,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior()
                              .copyWith(overscroll: false),
                          child: ListView.builder(
                            itemBuilder: (context, index) => GameWidget(
                              game: value.games[index],
                              selectGame: value.selectRAWGGame,
                              unselectGame: value.unselectRAWGGame,
                              editWishListState: value.deleteGame,
                              goToGameDetailsScreen:
                                  value.goToGameDetailsScreen,
                              addGameToHistory: value.addGameToHistory,
                              tag: value.games[index].id.toString(),
                            ),
                            itemCount: value.games.length,
                          ),
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }

  @override
  FavoriteTabViewModel initViewModel() {
    return FavoriteTabViewModel(
        getGamesForWishListUseCase: injectGetGamesForWishListUseCase(),
        addGameToHistoryUseCase: injectAddGameToHistoryUseCase());
  }
}
