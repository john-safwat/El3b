import 'package:core/Theme/theme.dart';
import 'package:presentation/Models/Button.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Button button;
  CustomButton({required this.button, super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => button.onClickListener(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: button.color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                button.icon,
                size: 25,
                color: MyTheme.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              button.title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}