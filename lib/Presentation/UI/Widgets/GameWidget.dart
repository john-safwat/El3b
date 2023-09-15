import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GameWidget extends StatelessWidget {
  RAWGGame game;
  Function selectGame ;
  Function unselectGame ;
  Function editWishListState;

  GameWidget({
    required this.game ,
    required this.selectGame ,
    required this.unselectGame,
    required this.editWishListState
  });

  @override
  Widget build(BuildContext context) {
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
      child: GestureDetector(
        onLongPress: () => selectGame(game),
        onLongPressEnd: (details) =>  unselectGame(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: MyTheme.lightPurple,
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
            // the backGround Image
            Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: game.backgroundImage!??"",
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      fit: BoxFit.cover ,
                      width: double.infinity,
                    ),
                    errorWidget: (context, url, error) =>  Image.asset(
                      "Assets/Images/errorImage.png" ,
                      fit: BoxFit.cover ,
                      width: double.infinity,
                    ),
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: MyTheme.lightPurple,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child:const Center(child: CircularProgressIndicator(color: MyTheme.offWhite,),),
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
                            Colors.transparent,
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
                            fontSize: 26,
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
            // is in wish list badge
            Positioned(
              bottom: 20 ,
              right: localProvider.isEn() ? 20 : null,
              left: localProvider.isEn() ? null : 20,
              child: InkWell(
                onTap: () => editWishListState(game),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyTheme.lightPurple,
                  ),
                  child: SvgPicture.asset(game.inWishList!? "Assets/SVG/liked.svg": "Assets/SVG/notLiked.svg" , color: MyTheme.offWhite, width: 30,),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
