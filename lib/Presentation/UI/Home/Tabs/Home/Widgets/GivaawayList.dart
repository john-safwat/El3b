import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGames.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GiveawayGameWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class GiveawayList extends StatelessWidget {
  List<GiveawayGames> games ;
  Function selectGame ;
  Function unselectGame ;
  Function urlLauncher ;
  GiveawayList({required this.games , required this.selectGame , required this.unselectGame , required this.urlLauncher});

  @override
  Widget build(BuildContext context) {

    return CarouselSlider(
      items: games.map((e) =>  GiveawayGameWidget(game: e, selectGame: selectGame , unselectGame: unselectGame, urlLauncher: urlLauncher,)).toList(),
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
