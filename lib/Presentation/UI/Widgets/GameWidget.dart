import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class GameWidget extends StatelessWidget {
  RAWGGame game;
  Function selectGame ;
  Function unselectGame ;

  GameWidget({
    required this.game ,
    required this.selectGame ,
    required this.unselectGame
  });

  @override
  Widget build(BuildContext context) {
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
      child: GestureDetector(
        onLongPress: () => selectGame(game),
        onLongPressEnd: (details) =>  unselectGame(),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("Assets/Images/loadingImage.png" , width: double.infinity, fit: BoxFit.cover,)),
            // the backGround Image
            Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: game.backgroundImage!??"",
                    imageBuilder: (context, imageProvider) => Image.network(
                      game.backgroundImage! ,
                      fit: BoxFit.cover ,
                      width: double.infinity,
                    ),
                    errorWidget: (context, url, error) =>  Image.asset(
                      "Assets/Images/errorImage.png" ,
                      fit: BoxFit.cover ,
                      width: double.infinity,
                    ),
                    placeholder: (context, url) => Stack(
                      children: [
                        Image.asset("Assets/Images/loadingImage.png" , width: double.infinity, fit: BoxFit.cover,),
                        Center(child: LoadingBouncingGrid.circle(
                          backgroundColor: MyTheme.lightPurple,
                        )),
                      ],
                    ),
                  )
              ),
            ),
            // the overlay color and the game title
            Positioned.fill(
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
                        child: Text(
                          game.name!,
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: MyTheme.offWhite,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Expanded( child: SizedBox())
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
