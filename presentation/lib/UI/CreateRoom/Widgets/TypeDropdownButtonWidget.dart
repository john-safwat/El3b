import 'package:core/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:presentation/Models/RoomType.dart';

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
