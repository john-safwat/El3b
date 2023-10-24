import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/Models/RoomType.dart';
import 'package:flutter/material.dart';

class TypeDropdownButtonWidget extends StatelessWidget {

  RoomType roomType;
  TypeDropdownButtonWidget({required this.roomType ,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(roomType.icon ,color: MyTheme.lightPurple,),
        const SizedBox(width: 10,),
        Text(roomType.title , style: Theme.of(context).textTheme.displayMedium!),
      ],
    );
  }
}
