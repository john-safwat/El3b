import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  String description;
  String title;
  DescriptionWidget({required this.title , required this.description , super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: title),
          const SizedBox(height: 20,),
          Text(description , style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: MyTheme.offWhite ,
          ),),
        ],
      ),
    );
  }
}
