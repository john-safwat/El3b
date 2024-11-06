
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Developers/developers.dart';
import 'package:flutter/material.dart';


class DeveloperWidget extends StatelessWidget {
  Developer developer;
  Function goToDeveloperProfile;
  DeveloperWidget({required this.developer,required this.goToDeveloperProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // the developer image
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: developer.image ?? "",
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.cover,
              width: 150,
              height: double.infinity,
            ),
            errorWidget: (context, url, error) => Image.asset(
              "Assets/Images/errorImage.png",
              fit: BoxFit.cover,
              width: 150,
              height: double.infinity,
            ),
            placeholder: (context, url) => Container(
              width: 150,
              height: double.infinity,
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
// The developer name and data
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                    onPressed:(){
                      goToDeveloperProfile(developer);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Text(developer.name??"No Name Found" , textAlign: TextAlign.center , maxLines: 1,)),
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
