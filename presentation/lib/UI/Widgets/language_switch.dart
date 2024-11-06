import 'package:core/Providers/local_provider.dart';
import 'package:core/Theme/theme.dart';
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
      style: ToggleStyle(
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.transparent,
        borderColor: MyTheme.lightPurple,
        indicatorColor: MyTheme.lightPurple
      ),
      spacing:10,
      iconBuilder: (value, foreground) {
        if (value == "en") {
          return Flag(Flags.united_kingdom);
        } else {
          return Flag(Flags.egypt);
        }
      },
      onChanged: (p0) => localProvider.isEn()? localProvider.changeLocal("ar"):localProvider.changeLocal("en"),
      borderWidth: 2,
    );
  }
}
