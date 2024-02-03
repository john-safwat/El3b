import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  String content;
  TextCard({required this.content ,super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
