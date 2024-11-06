import 'package:flutter/material.dart';

class ListPoints extends StatelessWidget {
  String content;

  ListPoints({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Text(
                content,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15,)
      ],
    );
  }
}
