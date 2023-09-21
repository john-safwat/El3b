import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Genres/Genre.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabButton extends StatelessWidget {
  Genre genre;
  bool isSelected;
  TabButton({required this.genre, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyTheme.lightPurple,
          image: DecorationImage(
            image: NetworkImage(genre.imageBackground??''),
            fit: BoxFit.cover,
            opacity: isSelected?0 : 0.3
          )
        ),
        child: Text(
          genre.name??"No Name",
          style: Theme.of(context).textTheme.displayMedium!.copyWith(color:MyTheme.offWhite),
        )
    );
  }
}