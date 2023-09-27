
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  String title ;
  List<double> ratings;
  List<String> ratingMeanings;
  RatingWidget({required this.title , required this.ratings , required this.ratingMeanings});

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
            height:50,
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
          ),
          const SizedBox(height: 20,),
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 10
            ),
            children: [
              TypeWidget(ratingMeanings[0] , const Color(0xFF85CC36)),
              TypeWidget(ratingMeanings[1] , const Color(0xFF4E6DD1)),
              TypeWidget(ratingMeanings[2] , const Color(0xFFF9A541)),
              TypeWidget(ratingMeanings[3] , const Color(0xFFF73645)),
            ],
          )
        ],
      ),
    );
  }
}


class TypeWidget extends StatelessWidget {
  String title ;
  Color color;
  TypeWidget(this.title , this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10 ,
          width: 10,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        const SizedBox(width: 10,),
        Text(title, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.white),),
        const SizedBox(width: 10,),
      ],
    );
  }
}

