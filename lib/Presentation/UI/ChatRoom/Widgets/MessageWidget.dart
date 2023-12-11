import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {

  Message message;
  MessageWidget({required this.message , super.key});

  @override
  Widget build(BuildContext context) {
    AppConfigProvider appConfigProvider = Provider.of<AppConfigProvider>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: appConfigProvider.user!.uid == message.senderId? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        appConfigProvider.user!.uid == message.senderId?const SizedBox(): Container(
          width: 25,
          height: 25,
          margin:const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: MyTheme.purple,
            borderRadius: BorderRadius.circular(100)
          ),
          child: CachedNetworkImage(
            imageUrl: message.senderImage,
            imageBuilder: (context, imageProvider) => ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(
                image: imageProvider,
                fit: BoxFit.cover,
                width: 25,
                height: 25,
              )
            ),
            errorWidget: (context, url, error) => Image.asset("Assets/Images/DarkLogo2.png"),
          )
        ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          constraints: BoxConstraints(minWidth: 0, maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration:BoxDecoration(
            color: appConfigProvider.user!.uid == message.senderId? MyTheme.lightPurple:MyTheme.purple,
            borderRadius: BorderRadius.only(
              bottomLeft:const Radius.circular(15),
              bottomRight: const Radius.circular(15),
              topRight: appConfigProvider.user!.uid == message.senderId?const Radius.circular(0) :const Radius.circular(15),
              topLeft: appConfigProvider.user!.uid == message.senderId?const Radius.circular(15) :const Radius.circular(0)
            )
          ),
          child: Text(message.content , style: Theme.of(context).textTheme.displayMedium,),
        ),
      ],
    );
  }
}