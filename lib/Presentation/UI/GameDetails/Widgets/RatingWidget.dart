import 'package:El3b/Domain/Models/Games/GameDetails/Ratings.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  String title ;
  double count ;
  List<Ratings> ratings;
  RatingWidget({required this.title , required this.count, required this.ratings , super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: title),
        Container(
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF85CC36),
                Color(0xFF4E6DD1),
                Color(0xFFF9A541),
                Color(0xFFF73645),
              ],
              stops: [
                (ratings[0].count! / count),
                (ratings[1].count! / count),
                (ratings[2].count! / count),
                (ratings[1].count! / count),
              ]
            )
          ),
        )
      ],
    );
  }
}
