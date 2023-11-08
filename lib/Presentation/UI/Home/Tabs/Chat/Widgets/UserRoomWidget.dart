import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserRoomWidget extends StatelessWidget {
  Room room;
  Function onPress;
  UserRoomWidget({required this.room ,required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress(room);
      },
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            // the backGround Image
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: room.image,
                  imageBuilder: (context, imageProvider) =>Image(image: imageProvider,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "Assets/Images/errorImage.png",
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                  placeholder: (context, url) => Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: MyTheme.lightPurple,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child:const Center(child: CircularProgressIndicator(color: MyTheme.offWhite,),),
                  ),
                )),
            const SizedBox(height: 10,),
            Text(
              room.name,
              style: Theme.of(context).textTheme.displaySmall,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
