import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Achievements/Achievement.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GameAchievementsListWidget extends StatelessWidget {
  String title;
  List<Achievement> achievements;
  String buttonTitle;
  Function goToGameAchievementsList;
  GameAchievementsListWidget(
      {required this.title,
      required this.achievements,
      required this.buttonTitle,
      required this.goToGameAchievementsList,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(title: title),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1),
          itemBuilder: (context, index) => CachedNetworkImage(
            imageUrl: achievements[index].image ?? "",
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            errorWidget: (context, url, error) => Image.asset(
              "Assets/Images/errorImage.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            placeholder: (context, url) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: MyTheme.lightPurple,
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: CircularProgressIndicator(
                  color: MyTheme.offWhite,
                ),
              ),
            ),
          ),
          itemCount: achievements.length,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
              onPressed: () {
                goToGameAchievementsList();
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  buttonTitle,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: MyTheme.offWhite),
                ),
              )),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}
