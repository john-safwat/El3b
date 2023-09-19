
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  String label;
  Function onChangeFunction;
  CustomSearchBar({required this.label, required this.onChangeFunction});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return TextField(
      onChanged: (value) {
        print(value);
        onChangeFunction(value);
        } ,
      style: textTheme.displayMedium,
      cursorColor: MyTheme.lightPurple,
      keyboardType: TextInputType.text,
      cursorHeight: 20,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: label,
        filled: true,
        fillColor: themeProvider.isDark()?MyTheme.purple: MyTheme.offWhite,
        hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: themeProvider.isDark()? MyTheme.grayPurple : MyTheme.lightPurple
        ),
        prefixIcon : Icon(BoxIcons.bx_search_alt , size: 30, color: themeProvider.isDark()?MyTheme.grayPurple : MyTheme.lightPurple,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:const BorderSide(
              width: 2,
              color: MyTheme.lightPurple,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:const BorderSide(
            width: 2,
            color: MyTheme.lightPurple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: MyTheme.lightPurple,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
      ),
    );
  }
}