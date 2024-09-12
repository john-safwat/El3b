
import 'package:core/Theme/Theme.dart';
import 'package:domain/Models/Games/GameDetails/Genres.dart';
import 'package:flutter/material.dart';
import 'package:presentation/UI/GameDetails/Widgets/TitleWidget.dart';

class GameGenresWidget extends StatelessWidget {

  String title ;
  List<Genres> genres;
  GameGenresWidget({required this.title ,required this.genres, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TitleWidget(title: title),
          ),
          Wrap(
            children: genres.map((e) => Container(
              padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
              margin :const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
              decoration: BoxDecoration(
                color: MyTheme.lightPurple,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: MyTheme.lightPurple,
                    offset: Offset(0,0),
                    blurRadius: 20 ,
                  )
                ]
              ),
              child: Text(e.name??"N/A" , style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: MyTheme.offWhite,
                fontWeight: FontWeight.w500
              ),),
            )).toList(),
          )
        ],
      ),
    );
  }
}
