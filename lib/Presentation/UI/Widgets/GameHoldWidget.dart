import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GameHoldWidget extends StatelessWidget {
  RAWGGame game;
  GameHoldWidget({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Animate(
      autoPlay: true,
      child: Stack(
        children: [
          // the shadow in the back ground
          Column(
            children: [
              Expanded(
                child: Container(
                  color: MyTheme.darkPurple.withOpacity(0.5),
                ),
              )
            ],
          ),
          // the game details
          Animate(
            effects: const [ScaleEffect(duration: Duration(milliseconds: 100))],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // the image
                  Stack(
                    children: [
                      // the image
                      Positioned(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl: game.backgroundImage ?? "",
                              imageBuilder: (context, imageProvider) =>
                                  Image.network(
                                game.backgroundImage!,
                                width: double.infinity,

                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "Assets/Images/errorImage.png",
                              ),
                              placeholder: (context, url) => Container(
                                width: double.infinity,
                                height: 170,
                                decoration: BoxDecoration(
                                    color: MyTheme.lightPurple,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child:const Center(child: CircularProgressIndicator(color: MyTheme.offWhite,),),
                              ),
                            )),
                      ),
                      Positioned(
                          top:10,
                          right: localProvider.isEn() ? 10 : null,
                          left: localProvider.isEn() ? null :10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: game.metacritic! > 75
                                    ? MyTheme.green
                                    : game.metacritic! > 50
                                        ? MyTheme.yellow
                                        : MyTheme.red),
                            child: Text(
                              game.metacritic!.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                  color: MyTheme.offWhite , fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                  // the content
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: themeProvider.isDark()
                            ? MyTheme.purple
                            : MyTheme.offWhite,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // game title and love badge
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                game.name ?? "Title Not Found",
                                maxLines: 5,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SvgPicture.asset(
                              game.inWishList!
                                  ? "Assets/SVG/liked.svg"
                                  : "Assets/SVG/notLiked.svg",
                              color: themeProvider.isDark()
                                  ? MyTheme.offWhite
                                  : MyTheme.lightPurple,
                              width: 30,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // the release date
                        Text(game.released ?? "--/--/----",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: MyTheme.grayPurple)),
                        const SizedBox(
                          height: 10,
                        ),
                        // the Platforms
                        Wrap(
                          children: game.icons
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      e,
                                      color: themeProvider.isDark()
                                          ? MyTheme.offWhite
                                          : MyTheme.lightPurple,
                                      width: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // the rating
                        Row(
                          children: [
                            SvgPicture.asset(
                              "Assets/SVG/star.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${game.rating.toString()} / 5",
                              style: Theme.of(context).textTheme.displayMedium!,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // the genre
                        Wrap(
                          children: game.genres!
                              .map((e) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    decoration: BoxDecoration(
                                      color: MyTheme.lightPurple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      e.name ?? "Not Found",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(color: MyTheme.offWhite),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ).fade(duration: const Duration(milliseconds: 200));
    ;
  }
}
