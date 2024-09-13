import 'package:core/Providers/theme_provider.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Room/room.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class PublicRoomsWidget extends StatelessWidget {
  Room room;
  Function onPress;
  PublicRoomsWidget({required this.room,required this.onPress ,  super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        onPress(room);
      },
      child: Stack(
        children: [
          // the backGround Image
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: room.image,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  height: 90,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "Assets/Images/errorImage.png",
                  fit: BoxFit.cover,
                  height: 90,
                  width: double.infinity,
                ),
                placeholder: (context, url) => Container(
                  height: 90,
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
              )),
          // upper layer
          Positioned.fill(
              child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: themeProvider.isDark()
                    ? MyTheme.purple.withOpacity(0.75)
                    : MyTheme.lightPurple.withOpacity(0.75)),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: room.image,
                      imageBuilder: (context, imageProvider) => Hero(
                        tag: room.id,
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: 70,
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "Assets/Images/errorImage.png",
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: 70,
                      ),
                      placeholder: (context, url) => Container(
                        height: double.infinity,
                        width: 70,
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  room.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: MyTheme.offWhite),
                )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      EvaIcons.people_outline,
                      color: MyTheme.offWhite,
                      size: 30,
                    ),
                    Text(
                      room.users.length <= 1000
                          ? room.users.length.toString()
                          : "${room.users.length / 1000} K",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: MyTheme.offWhite, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
