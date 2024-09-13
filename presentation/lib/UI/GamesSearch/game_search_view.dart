import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/add_game_to_history_use_case.dart';
import 'package:domain/UseCase/search_from_game_from_server_use_case.dart';
import 'package:presentation/UI/GamesSearch/game_search_view_model.dart';
import 'package:presentation/UI/Widgets/custom_search_bar.dart';
import 'package:presentation/UI/Widgets/error_message_widget.dart';
import 'package:presentation/UI/Widgets/game_hold_widget.dart';
import 'package:presentation/UI/Widgets/game_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GameSearchView extends StatefulWidget {
  static const String routeName = "HomeSearch";

  const GameSearchView({super.key});

  @override
  State<GameSearchView> createState() => _GameSearchViewState();
}

class _GameSearchViewState extends BaseState<GameSearchView, GameSearchViewModel> {
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
            onSubmit: viewModel.search,
          ),
          titleSpacing: 10,
        ),
        body: Consumer<GameSearchViewModel>(
          builder: (context, value, child) {
            if (value.errorMessage != null) {
              return SingleChildScrollView(
                child: ErrorMessageWidget(
                  errorMessage: value.errorMessage ?? "There is A error",
                  fixErrorFunction: () {},
                ),
              );
            } else if (value.loading) {
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
            } else if (value.games.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Lottie.asset("Assets/Animations/search2.json",
                        width: 150, height: 150),
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
                            itemBuilder: (context, index) => GameWidget(
                              tag: value.games[index].id.toString(),
                              game: value.games[index],
                              selectGame: value.selectRAWGGame,
                              unselectGame: value.unselectRAWGGame,
                              editWishListState: value.editGameWishListState,
                              goToGameDetailsScreen:
                                  value.goToGameDetailsScreen,
                              addGameToHistory: value.addGameToHistory,
                            ),
                            itemCount: value.games.length,
                          ),
                        ),
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
        ),
      ),
    );
  }

  @override
  GameSearchViewModel initViewModel() {
    return GameSearchViewModel(
        searchFromGameFromServerUseCase:
            injectSearchFromGameFromServerUseCase(),
        addGameToHistoryUseCase: injectAddGameToHistoryUseCase());
  }
}