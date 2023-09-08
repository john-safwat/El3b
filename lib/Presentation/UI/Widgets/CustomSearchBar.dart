import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class CustomSearchBarButton extends StatelessWidget {
  const CustomSearchBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    LocalProvider local = Provider.of<LocalProvider>(context);
    AppConfigProvider configProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2 ,color: MyTheme.lightPurple)
      ),
      child: Row(
        children: [
          Icon(BoxIcons.bx_search_alt , size: 30, color: MyTheme.lightPurple),
          Text("")
        ],
      ),
    );
  }
}
