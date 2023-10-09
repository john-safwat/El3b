import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:El3b/Domain/UseCase/AddGameToWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/DeleteGameFromWishListUseCase.dart';
import 'package:El3b/Domain/UseCase/GatGamesFromHistoryUseCase.dart';
import 'package:El3b/Presentation/UI/History/HistoryNavigator.dart';
import 'package:El3b/Presentation/UI/History/HistoryViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameHoldWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/GameWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatefulWidget {
  static const String routeName = "History";
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends BaseState<HistoryView, HistoryViewModel>
    implements HistoryNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(viewModel!.local!.history),
        ),
        body: ChangeNotifierProvider(
          create: (context) => viewModel!,
          child: Consumer<HistoryViewModel>(
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
                                editWishListState: value.editGameWishListState,
                                goToGameDetailsScreen:
                                    value.goToGameDetailsScreen,
                                addGameToHistory: value.addGameToHistory,
                              ),
                              itemCount: value.games.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                    value.rawgGameSelected
                        ? GameHoldWidget(game: value.rawgGameSelectedGame)
                        : const SizedBox()
                  ],
                );
              }
            },
          ),
        ));
  }

  @override
  HistoryViewModel initViewModel() {
    return HistoryViewModel(
      gamesFromHistoryUseCase: injectGatGamesFromHistoryUseCase(),
      addGameToHistoryUseCase: injectAddGameToHistoryUseCase(),
      deleteGameFromWishListUseCase: injectDeleteGameFromWishListUseCase(),
      addGameToWishListUseCase: injectAddGameToWishListUseCase()
    );
  }
}
