import 'package:core/Theme/theme.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  String title;
  TitleWidget({required this.title , super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title , style: Theme.of(context).textTheme.displayLarge!.copyWith(
        color: MyTheme.offWhite ,
        fontWeight: FontWeight.w500
    ),);
  }
}
