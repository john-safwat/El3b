import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var localProvider = Provider.of<LocalProvider>(context);
    return AnimatedToggleSwitch.rolling(
      current: localProvider.getLocal(),
      values: const ["en", "ar"],
      height: 40,
      colorBuilder: (value) => MyTheme.lightPurple,
      iconBuilder: (value, size, foreground) {
        if (value == "en") {
          return Flag(Flags.united_kingdom);
        } else {
          return Flag(Flags.egypt);
        }
      },
      onChanged: (p0) => localProvider.isEn()? localProvider.changeLocal("ar"):localProvider.changeLocal("en"),
      transitionType: ForegroundIndicatorTransitionType.fading,
      borderRadius: BorderRadius.circular(12),
      borderColor: MyTheme.lightPurple,
      borderWidth: 1,
      dif: 10,
    );
  }
}
