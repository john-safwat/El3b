
import 'package:core/Theme/Theme.dart';
import 'package:domain/Models/Genres/Genre.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  Genre genre;
  Function goToSearchScreen;
  TabButton({required this.genre , required this.goToSearchScreen});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToSearchScreen(genre.id.toString());
      },
      child: Stack(
        children: [
          // background image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                // image
                CachedNetworkImage(
                  imageUrl: genre.imageBackground??'',
                  imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
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
                    )
                  ),
                )
              ],
            ),
          ),
          // title
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: MyTheme.lightPurple.withOpacity(0.65),
                borderRadius: BorderRadius.circular(15)
            ),
            child: Center(
              child: Text(
                genre.name??"No Name",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  color: MyTheme.offWhite
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}