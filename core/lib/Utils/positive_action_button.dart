import 'package:flutter/material.dart';

class PositiveActionButton extends StatelessWidget {
  VoidCallback? posAction;
  String posActionTitle;
  PositiveActionButton({required this.posActionTitle , this.posAction , super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:  ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
              if (posAction != null){
                posAction!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FittedBox(child: Text(posActionTitle)),
            )
        )
    );
  }
}
