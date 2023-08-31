import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomSheetWidget extends StatelessWidget {
  String title ;
  String cameraTitle ;
  String galleryTitle;
  MyBottomSheetWidget({required this.title ,required this.cameraTitle , required this.galleryTitle});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: FittedBox(
            child: Text(
              title,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.isDark()? MyTheme.offWhite : MyTheme.lightPurple,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child:ElevatedButton(
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(child: Text(cameraTitle,)),
                ),
              )
            ),
            const SizedBox(width: 10,),
            Expanded(
              child:ElevatedButton(
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(child: Text(galleryTitle,)),
                ),
              )
            )
          ],
        ),
      ),
    ]);
  }
}
