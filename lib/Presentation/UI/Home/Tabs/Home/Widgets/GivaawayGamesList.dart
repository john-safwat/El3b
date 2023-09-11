import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GiveawayGamesWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class GiveawayGamesList extends StatelessWidget {
  List<GiveawayGame> games ;
  Function selectGame ;
  Function unselectGame ;
  Function urlLauncher ;
  GiveawayGamesList({required this.games , required this.selectGame , required this.unselectGame , required this.urlLauncher});

  @override
  Widget build(BuildContext context) {

    return CarouselSlider(
      items: games.map((e) =>  GiveawayGamesWidget(game: e, selectGame: selectGame , unselectGame: unselectGame, urlLauncher: urlLauncher,)).toList(),
      options: CarouselOptions(
        animateToClosest: false,
        height: 170,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height
      ),
    );
  }
}
