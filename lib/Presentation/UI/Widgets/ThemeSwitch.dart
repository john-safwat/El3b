import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
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
      colorBuilder: (value) => MyTheme.lightPurple,
      iconBuilder: (value, size, foreground) {
        if (value == ThemeMode.dark) {
          return Icon(EvaIcons.moon , color: theme.isDark()? MyTheme.offWhite : MyTheme.lightPurple ,);
        } else {
          return const Icon(EvaIcons.sun , color: MyTheme.offWhite ,);
        }
      },
      onChanged: (p0) => theme.changeTheme(theme.isDark()? ThemeMode.light : ThemeMode.dark),
      transitionType: ForegroundIndicatorTransitionType.fading,
      borderRadius: BorderRadius.circular(12),
      borderColor: MyTheme.lightPurple,
      borderWidth: 1,
      dif: 10,
    );
  }
}
