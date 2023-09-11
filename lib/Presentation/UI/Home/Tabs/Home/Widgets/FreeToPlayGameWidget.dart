import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:super_banners/super_banners.dart';

class FreeToPlayGameWidget extends StatelessWidget {
  FreeToPlayGame game;
  Function selectGame ;
  Function unselectGame ;
  Function urlLauncher;

  FreeToPlayGameWidget({required this.game , required this.selectGame , required this.unselectGame , required this.urlLauncher});

  @override
  Widget build(BuildContext context) {
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () => urlLauncher(game.gameUrl),
        onLongPress: () => selectGame(game),
        onLongPressEnd: (details) =>  unselectGame(),
        child: Stack(
          children: [
            // the backGround Image
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: game.thumbnail!??"",
                  imageBuilder: (context, imageProvider) => Image.network(
                    game.thumbnail! ,
                    fit: BoxFit.cover ,
                    width: double.infinity,
                  ),
                  errorWidget: (context, url, error) =>  Image.asset(
                    "Assets/Images/errorImage.png" ,
                    fit: BoxFit.cover ,
                    width: double.infinity,
                  ),
                  placeholder: (context, url) => Center(child: LoadingBouncingGrid.circle(
                    backgroundColor: themeProvider.isDark() ? MyTheme.offWhite : MyTheme.lightPurple,
                  )),
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
                            fontSize: 22,
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
          ],
        ),
      ),
    );
  }
}
