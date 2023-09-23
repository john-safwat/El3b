import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSearchBarButton extends StatelessWidget {
  Function navigation;
  CustomSearchBarButton({required this.navigation});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    AppConfigProvider configProvider = Provider.of<AppConfigProvider>(context);
    AppLocalizations local = AppLocalizations.of(context)!;
    return InkWell(
      onTap: (){
        navigation();
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 11 , horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2 ,color: MyTheme.lightPurple),
          color: themeProvider.isDark()?MyTheme.purple :MyTheme.offWhite
        ),
        child: Row(
          children: [
            Icon(BoxIcons.bx_search_alt , size: 22, color: themeProvider.isDark()?MyTheme.grayPurple : MyTheme.lightPurple,),
            const SizedBox(width: 12,),
            Expanded(
              child: Text(
                "${local.whatAreYouSearchingFor}${configProvider.getUser()!.displayName!.split(" ")[0]}",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: themeProvider.isDark()?MyTheme.grayPurple : MyTheme.lightPurple,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
