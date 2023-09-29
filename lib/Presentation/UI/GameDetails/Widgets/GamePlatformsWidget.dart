import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/GameDetails/Platforms.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GamePlatformsWidget extends StatelessWidget {
  String title;
  List<Platforms> platforms;
  GamePlatformsWidget(
      {required this.title, required this.platforms, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [TitleWidget(title: title)],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: platforms
                .map((e) => Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          // the background image
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl: e.platform!.imageBackground ?? "",
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
                          ),
                          // the game data
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyTheme.purple.withOpacity(0.8),
                            ),
                            child: Column(
                              children: [
                                TitleWidget(title: e.platform!.name ?? "No Name"),
                                SizedBox(
                                  height: e.requirements!.minimum != null ? 20 : 0,
                                ),
                                e.requirements!.minimum != null
                                    ? Text(
                                        e.requirements!.minimum!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: MyTheme.offWhite),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  height: e.requirements!.minimum != null ? 20 : 0,
                                ),
                                e.requirements!.recommended != null
                                    ? Text(e.requirements!.recommended ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: MyTheme.offWhite))
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ))
                .toList(),
          )
        ],
      ),
    );
  }
}
