import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/AddGameToHistoryUseCase.dart';
import 'package:domain/UseCase/GatGamesFromHistoryUseCase.dart';
import 'package:presentation/UI/History/HistoryNavigator.dart';
import 'package:presentation/UI/History/HistoryViewModel.dart';
import 'package:presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:presentation/UI/Widgets/GameHoldWidget.dart';
import 'package:presentation/UI/Widgets/GameWidget.dart';
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
    viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(viewModel.local!.history),
        ),
        body: ChangeNotifierProvider(
          create: (context) => viewModel,
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
                        ),
                      ],
                    ),
                    value.rawgGameSelected
                        ? GameHoldWidget(
                            game: value.rawgGameSelectedGame,
                            tag: viewModel.rawgGameSelectedGame.id.toString(),
                          )
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
    );
  }
}
