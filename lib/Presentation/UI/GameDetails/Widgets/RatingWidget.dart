import 'package:El3b/Domain/Models/Games/GameDetails/Ratings.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  String title ;
  List<double> ratings;
  RatingWidget({required this.title , required this.ratings , super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: title),
          const SizedBox(height: 20,),
          Container(
            height:60,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: const [
                  Color(0xFF85CC36),
                  Color(0xFF85CC36),
                  Color(0xFF4E6DD1),
                  Color(0xFF4E6DD1),
                  Color(0xFFF9A541),
                  Color(0xFFF9A541),
                  Color(0xFFF73645),
                  Color(0xFFF73645),
                ],
                stops: ratings
              )
            ),
          )
        ],
      ),
    );
  }
}
