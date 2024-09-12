import 'package:domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:presentation/UI/Home/Tabs/Home/Widgets/FreeToPlayGamesWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FreeToPlayGamesList extends StatelessWidget {
  List<FreeToPlayGame> games;

  Function selectGame;

  Function unselectGame;

  Function urlLauncher;


  FreeToPlayGamesList(
      {
      required this.games,
      required this.selectGame,
      required this.unselectGame,
      required this.urlLauncher});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: games
          .map((e) => FreeToPlayGameWidget(
                game: e,
                selectGame: selectGame,
                unselectGame: unselectGame,
                urlLauncher: urlLauncher,
              ))
          .toList(),
      options: CarouselOptions(
          animateToClosest: false,
          viewportFraction: 0.7,
          height: 150,
          initialPage: 26,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height),
    );
  }
}
