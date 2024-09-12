import 'package:core/Theme/theme.dart';
import 'package:flutter/material.dart';

class ReleaseDateWidget extends StatelessWidget {

  String date;

  ReleaseDateWidget({required this.date , super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(date , style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyTheme.offWhite),)
        ],
      ),
    );
  }
}
