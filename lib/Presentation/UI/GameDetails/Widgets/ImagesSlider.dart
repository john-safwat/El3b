import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Games/RAWG/ShortScreenshots.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatelessWidget {

  List<ShortScreenshots> images ;
  ImagesSlider({required this.images , super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((e) =>
          // the backGround Image
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: e.image??"",
                imageBuilder: (context, imageProvider) => Image(image: imageProvider,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) =>  Image.asset(
                  "Assets/Images/errorImage.png" ,
                  fit: BoxFit.cover ,
                  width: double.infinity,
                ),
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyTheme.lightPurple,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child:const Center(child: CircularProgressIndicator(color: MyTheme.offWhite,),),
                ),
              ),
            ),
          )
      ).toList(),
      options: CarouselOptions(
          animateToClosest: false,
          viewportFraction: 0.8,
          initialPage: 0,
          height: 200,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height
      ),
    );
  }
}
