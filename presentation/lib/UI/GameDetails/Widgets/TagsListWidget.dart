import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Games/GameDetails/tags.dart';
import 'package:presentation/UI/GameDetails/Widgets/TitleWidget.dart';
import 'package:flutter/material.dart';

class TagsListWidget extends StatelessWidget {
  String title;
  List<Tags> tags;
  TagsListWidget({required this.title , required this.tags ,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              TitleWidget(title: title),
            ],
          ),
          const SizedBox(height: 20,),
          Wrap(
            children: tags.map((e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
              margin: const EdgeInsets.only(right: 10 , bottom: 10),
              decoration: BoxDecoration(
                color: MyTheme.lightPurple.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(e.name??"No Name" , style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.offWhite),),
            )).toList(),
          )
        ],
      ),
    );
  }
}
