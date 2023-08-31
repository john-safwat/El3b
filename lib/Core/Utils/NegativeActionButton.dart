import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NegativeActionButton extends StatelessWidget {
  VoidCallback? negativeAction;
  String negativeActionTitle;
  NegativeActionButton({required this.negativeActionTitle , this.negativeAction , super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.isDark()?MyTheme.purple : MyTheme.offWhite),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side:const BorderSide(width: 2, color: MyTheme.lightPurple),
                )
            )
        ),
        onPressed: (){
          Navigator.pop(context);
          if (negativeAction != null){
            negativeAction!();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(negativeActionTitle,style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: theme.isDark()?MyTheme.offWhite : MyTheme.lightPurple,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
      )
    );
  }
}
