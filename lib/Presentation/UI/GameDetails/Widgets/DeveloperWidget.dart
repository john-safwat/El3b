import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DeveloperWidget extends StatelessWidget {
  Developers developer;
  DeveloperWidget({required this.developer, super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          // the backGround Image
          CachedNetworkImage(
            imageUrl: developer.imageBackground ?? "",
            imageBuilder: (context, imageProvider) => Stack(
              children: [
                Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  width: 240,
                  height: double.infinity,
                ),
                Container(
                  width: 240,
                  height: double.infinity,
                  color: MyTheme.purple.withOpacity(0.70),
                )
              ],
            ),
            errorWidget: (context, url, error) => Image.asset(
              "Assets/Images/errorImage.png",
              fit: BoxFit.cover,
              width: 220,
              height: double.infinity,
            ),
            placeholder: (context, url) => Container(
              width: 220,
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
          // data
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // the developer image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: developer.image ?? "",
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      width: 80,
                      height: double.infinity,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "Assets/Images/errorImage.png",
                      fit: BoxFit.cover,
                      width: 80,
                      height: double.infinity,
                    ),
                    placeholder: (context, url) => Container(
                      width: 80,
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
                const SizedBox(
                  width: 10,
                ),
                // The developer name and data
                Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        developer.name ?? "No Name Found",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: MyTheme.offWhite, fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(local!.view,),
                          ],
                        )
                      )
                  ],
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
