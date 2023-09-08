import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGames.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiveawayGameWidget extends StatelessWidget {

  GiveawayGames game;
  GiveawayGameWidget({required this.game , super.key});

  @override
  Widget build(BuildContext context) {
    LocalProvider localProvider = Provider.of<LocalProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          // the backGround Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(game.image! , fit: BoxFit.cover , width: double.infinity, height: 160,)
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
          )
        ],
      ),
    );
  }
}
