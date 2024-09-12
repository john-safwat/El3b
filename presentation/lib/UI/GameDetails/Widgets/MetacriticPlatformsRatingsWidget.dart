
import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Games/GameDetails/metacritic_platforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MetacriticPlatformsRatingsWidget extends StatelessWidget {

  List<MetacriticPlatforms> metacriticPlatforms;

  MetacriticPlatformsRatingsWidget({required this.metacriticPlatforms  ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:  metacriticPlatforms.length,
              itemBuilder: (context, index) => Container(
                padding:const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: metacriticPlatforms[index].metascore! > 75
                        ? MyTheme.green
                        :  metacriticPlatforms[index].metascore! > 50
                        ? MyTheme.yellow
                        : MyTheme.red
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // the game score
                    Text(
                      metacriticPlatforms[index].metascore.toString() ,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: MyTheme.offWhite  ,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      " | ",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: MyTheme.offWhite  ,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SvgPicture.asset( metacriticPlatforms[index].platform!.icon??"" , color: MyTheme.white, width: 20,)
                  ],
                ),
              )
            )
          )
        ]
      ),
    );
  }
}
