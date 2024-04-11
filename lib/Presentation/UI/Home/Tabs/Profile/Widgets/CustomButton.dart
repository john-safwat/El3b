import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/Models/Button.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Button button;
  CustomButton({required this.button, super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => button.onClickListener(),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: button.color,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              button.icon,
              size: 40,
              color: MyTheme.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              button.title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}