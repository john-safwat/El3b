import 'package:core/Providers/local_provider.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:super_banners/super_banners.dart';

class GiveawayGamesWidget extends StatelessWidget {

  GiveawayGame game;
  Function selectGame ;
  Function unselectGame ;
  Function urlLauncher;
  GiveawayGamesWidget({required this.game , required this.selectGame , required this.unselectGame  , required this.urlLauncher});

  @override
  Widget build(BuildContext context) {
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    AppLocalizations local = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () => urlLauncher(game.openGiveawayUrl),
        onLongPress: () => selectGame(game),
        onLongPressEnd: (details) =>  unselectGame(),
        child: Stack(
          children: [
            // the backGround Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: game.image!??"",
                imageBuilder: (context, imageProvider) => Image(image: imageProvider,
                  fit: BoxFit.cover ,
                  width: double.infinity,
                  height: 170,
                ),
                errorWidget: (context, url, error) =>  Image.asset(
                  "Assets/Images/errorImage.png" ,
                  fit: BoxFit.cover ,
                  width: double.infinity,
                  height: 170,
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
              )
            ),
            // the overlay color and the game title
            Positioned(
              child: Container(
                // the overlay color
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient:  LinearGradient(
                    colors:const [
                      MyTheme.lightPurple,
                      Colors.transparent
                    ],
                    begin: localProvider.isEn()? Alignment.topLeft : Alignment.topRight,
                    end: localProvider.isEn()? Alignment.bottomRight : Alignment.bottomLeft
                  )
                ),
                padding: const EdgeInsets.all(20),
                height: double.infinity,
                // the title of the game
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        game.title!,
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: MyTheme.offWhite,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Expanded(flex : 3, child: SizedBox())
                  ],
                ),
              )
            ),
            // banner of the giveaway widget
            Positioned(
              top: 0,
              right: localProvider.isEn()? 0 : null,
              left: localProvider.isEn() ? null : 0,
              child: CornerBanner(
                bannerColor: MyTheme.lightPurple,
                bannerPosition:localProvider.isEn()? CornerBannerPosition.topRight :CornerBannerPosition.topLeft,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(local.giveaway , style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.offWhite),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
