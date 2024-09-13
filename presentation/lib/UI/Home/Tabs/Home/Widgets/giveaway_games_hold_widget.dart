import 'package:core/Providers/local_provider.dart';
import 'package:core/Providers/theme_provider.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:super_banners/super_banners.dart';

class GiveawayGamesHoldWidget extends StatelessWidget {
  GiveawayGame game;

  GiveawayGamesHoldWidget({required this.game});

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
                            imageUrl: game.image ?? "",
                            imageBuilder: (context, imageProvider) => Image(image: imageProvider),
                            errorWidget: (context, url, error) => Image.asset(
                              "Assets/Images/errorImage.png",
                            ),
                            placeholder: (context, url) => Container(
                              width: double.infinity,
                              height: 170,
                              decoration: BoxDecoration(
                                  color: MyTheme.lightPurple,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: MyTheme.offWhite,
                                ),
                              ),
                            ),
                          )),
                      // the giveaway title
                      Positioned(
                        top: 0,
                        right: localProvider.isEn() ? 0 : null,
                        left: localProvider.isEn() ? null : 0,
                        child: CornerBanner(
                          bannerColor: MyTheme.lightPurple,
                          bannerPosition: localProvider.isEn()
                              ? CornerBannerPosition.topRight
                              : CornerBannerPosition.topLeft,
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              local.giveaway,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: MyTheme.offWhite),
                            ),
                          ),
                        ),
                      )
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
                        // game title
                        Text(
                          game.title ?? "Title Not Found",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // the end date
                        Text("${local.endDate} ${game.endDate ?? "--/--/----"}",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayMedium),
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
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // instructions
                        Text(game.instructions ?? "Title Not Found",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displaySmall),
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
