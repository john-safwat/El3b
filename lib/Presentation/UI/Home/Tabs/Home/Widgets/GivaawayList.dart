
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGames.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/Widgets/GiveawayGameWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class GiveawayList extends StatelessWidget {
  List<GiveawayGames> games ;
  GiveawayList({required this.games});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: games.map((e) =>  GiveawayGameWidget(game: e,)).toList(),
      options: CarouselOptions(
        animateToClosest: false,
        height: 160,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height
      ),
    );
  }
}
