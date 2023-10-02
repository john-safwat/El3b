import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/GameAchievementsList/GameAchievementsListNavigator.dart';
import 'package:El3b/Presentation/UI/GameAchievementsList/GameAchievementsListViewModel.dart';
import 'package:flutter/material.dart';

class GameAchievementsListView extends StatefulWidget {

  String gameId;
  GameAchievementsListView({required this.gameId , super.key});

  @override
  State<GameAchievementsListView> createState() => _GameAchievementsListViewState();
}

class _GameAchievementsListViewState extends BaseState<GameAchievementsListView , GameAchievementsListViewModel> implements GameAchievementsListNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Placeholder();
  }

  @override
  GameAchievementsListViewModel initViewModel() {
    return GameAchievementsListViewModel(
      gameId: widget.gameId,
      getAllGameAchievementsUseCase:
    )
  }
}
