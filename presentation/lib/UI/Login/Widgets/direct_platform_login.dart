import 'package:core/Providers/local_provider.dart';
import 'package:core/Providers/theme_provider.dart';
import 'package:core/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DirectPlatformLogin extends StatelessWidget {
  String darkImage;
  String lightImage;
  String title;
  bool loading;
  Function login;

  DirectPlatformLogin(
      {required this.darkImage,
      required this.lightImage,
      required this.title,
      required this.login,
        required this.loading});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var local = Provider.of<LocalProvider>(context);
    return InkWell(
      onTap: (){
        login();
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyTheme.lightPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Platform Icon
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 70,
              decoration: BoxDecoration(
                  color: theme.isDark() ? MyTheme.offWhite : MyTheme.purple,
                  borderRadius: BorderRadius.only(
                    topLeft:local.isEn()? const Radius.circular(10) :const Radius.circular(0) ,
                    bottomLeft:local.isEn()?const Radius.circular(10) :const Radius.circular(0) ,
                    topRight: local.isEn()?const Radius.circular(0) : const Radius.circular(10),
                    bottomRight: local.isEn()?const Radius.circular(0) :const Radius.circular(10)
                  )),
              child:loading? SizedBox(
                height: 25,
                  child: CircularProgressIndicator(
                    color: theme.isDark()? MyTheme.lightPurple : MyTheme.offWhite,)): SvgPicture.asset(
                theme.isDark() ? darkImage : lightImage,
              ),
            ),
            Expanded(
                child: Center(
                  child: FittedBox(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: MyTheme.offWhite),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
