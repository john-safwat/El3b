import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Presentation/UI/GameDetails/GameDetailsNavigator.dart';
import 'package:El3b/Presentation/UI/GameDetails/GameDetailsViewModel.dart';
import 'package:flutter/material.dart';

class GameDetailsView extends StatefulWidget {

  static const String routeName = "GameDetails";

  RAWGGame game;
  GameDetailsView({required this.game , super.key});

  @override
  State<GameDetailsView> createState() => _GameDetailsViewState();
}

class _GameDetailsViewState extends BaseState<GameDetailsView , GameDetailsViewModel> implements GameDetailsNavigator{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModel!.game.name??"No Name",
        ),
      ),
    );
  }

  @override
  GameDetailsViewModel initViewModel() {
    return GameDetailsViewModel(game: widget.game);
  }
}
