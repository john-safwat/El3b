import 'package:core/Providers/ThemeProvider.dart';
import 'package:core/Theme/Theme.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch.rolling(
      current: theme.getTheme(),
      values: const [ThemeMode.dark, ThemeMode.light],
      height: 40,
      style: ToggleStyle(
        indicatorColor: MyTheme.lightPurple,
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.transparent,
        borderColor: MyTheme.lightPurple,
      ),
      spacing:10,
      iconBuilder:(value, foreground){
        if (value == ThemeMode.dark) {
          return Icon(EvaIcons.moon , color: theme.isDark()? MyTheme.offWhite : MyTheme.lightPurple ,);
        } else {
          return const Icon(EvaIcons.sun , color: MyTheme.offWhite ,);
        }
      },
      onChanged: (p0) => theme.changeTheme(theme.isDark()? ThemeMode.light : ThemeMode.dark),
      borderWidth: 1,

    );
  }
}
