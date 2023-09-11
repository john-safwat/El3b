import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FreeToPlayGamesHoldWidget extends StatelessWidget {
  FreeToPlayGame game;
  FreeToPlayGamesHoldWidget({required this.game});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    AppLocalizations local = AppLocalizations.of(context)!;
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
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: game.thumbnail ?? "",
                            imageBuilder: (context, imageProvider) =>
                                Image.network(
                              game.thumbnail!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "Assets/Images/errorImage.png",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            placeholder: (context, url) => Center(
                                child: LoadingBouncingGrid.circle(
                              backgroundColor: themeProvider.isDark()
                                  ? MyTheme.offWhite
                                  : MyTheme.lightPurple,
                            )),
                          )),
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
                        // game title and available platform
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                game.title ?? "Title Not Found",
                                textAlign: TextAlign.start,
                                maxLines: 4,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            SvgPicture.asset(
                              game.icon!,
                              color: themeProvider.isDark()
                                  ? MyTheme.offWhite
                                  : MyTheme.lightPurple,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        // Description
                        Text(game.shortDescription ?? "Title Not Found",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(height: 15,),

                        // the game genre
                        Text("It's a ${game.genre ?? "Title Not Found"} Game",
                            style: Theme.of(context).textTheme.displayMedium),
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
  }
}
