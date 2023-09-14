import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeToPlayGameWidget extends StatelessWidget {
  FreeToPlayGame game;
  Function selectGame;
  Function unselectGame;
  Function urlLauncher;

  FreeToPlayGameWidget(
      {required this.game,
      required this.selectGame,
      required this.unselectGame,
      required this.urlLauncher});

  @override
  Widget build(BuildContext context) {
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () => urlLauncher(game.gameUrl),
        onLongPress: () => selectGame(game),
        onLongPressEnd: (details) => unselectGame(),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "Assets/Images/loadingImage.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )),
            // the backGround Image
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: game.thumbnail ?? "",
                  imageBuilder: (context, imageProvider) => Image.network(
                    game.thumbnail!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,

                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "Assets/Images/errorImage.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  placeholder: (context, url) => Image.asset(
                    "Assets/Images/loadingImage.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )),
            // the overlay color and the game title
            Positioned.fill(
                child: Container(
              // the overlay color
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: const [MyTheme.lightPurple, Colors.transparent],
                      begin: localProvider.isEn()
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      end: localProvider.isEn()
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft)),
              padding: const EdgeInsets.all(20),
              height: double.infinity,
              // the title of the game
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text(
                      game.title!,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: MyTheme.offWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
