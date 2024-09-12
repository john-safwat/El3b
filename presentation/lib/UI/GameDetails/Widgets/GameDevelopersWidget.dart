
import 'package:domain/Models/Developers/developers.dart';
import 'package:flutter/material.dart';
import 'package:presentation/UI/GameDetails/Widgets/DeveloperWidget.dart';
import 'package:presentation/UI/GameDetails/Widgets/TitleWidget.dart';

class GameDevelopersWidget extends StatelessWidget {

  String title ;
  List<Developer> developers;
  Function goToDeveloperProfile;
  GameDevelopersWidget({required this.title , required this.developers,required this.goToDeveloperProfile ,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20,),
            TitleWidget(title: title),
          ],
        ),
        SizedBox(
          height: 250,
          child: ListView.separated(
            padding:const EdgeInsets.all(20),
            scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => DeveloperWidget(developer: developers[index] , goToDeveloperProfile: goToDeveloperProfile),
              separatorBuilder:(context, index) => const SizedBox(width: 20,),
              itemCount: developers.length
          ),
        )
      ],
    );
  }
}
