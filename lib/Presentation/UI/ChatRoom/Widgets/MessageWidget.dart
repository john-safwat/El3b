import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Messages/Message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {

  Message message;
  MessageWidget({required this.message , super.key});

  @override
  Widget build(BuildContext context) {
    AppConfigProvider appConfigProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.7,
        minWidth: 0
      ),
      decoration:BoxDecoration(
        color: appConfigProvider.user!.uid == message.senderId? MyTheme.lightPurple:MyTheme.purple,
        borderRadius: BorderRadius.only(
          bottomLeft:const Radius.circular(15),
          bottomRight: const Radius.circular(15),
          topRight: appConfigProvider.user!.uid == message.senderId?const Radius.circular(0) :const Radius.circular(15),
          topLeft: appConfigProvider.user!.uid == message.senderId?const Radius.circular(15) :const Radius.circular(0)
        )
      )

    );
  }
}