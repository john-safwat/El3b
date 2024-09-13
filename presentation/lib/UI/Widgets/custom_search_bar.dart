
import 'package:core/Providers/theme_provider.dart';
import 'package:core/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  String label;
  Function? onChangeFunction;
  Function? onSubmit;
  CustomSearchBar({required this.label, this.onChangeFunction , this.onSubmit});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return TextField(
      onSubmitted: (value) {
        onSubmit != null ? onSubmit!(value) : {};
      },
      onChanged: (value){
        onChangeFunction != null ? onChangeFunction!(value) : {};
      },
      style: textTheme.displaySmall,
      cursorColor: MyTheme.lightPurple,
      keyboardType: TextInputType.text,
      cursorHeight: 15,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: label,
        filled: true,
        fillColor: themeProvider.isDark()?MyTheme.purple: MyTheme.offWhite,
        hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: themeProvider.isDark()? MyTheme.grayPurple : MyTheme.lightPurple
        ),
        prefixIcon : Icon(BoxIcons.bx_search_alt , size: 22, color: themeProvider.isDark()?MyTheme.grayPurple : MyTheme.lightPurple,),
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