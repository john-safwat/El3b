import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {

  N? navigator;

  ThemeProvider? themeProvider;
  LocalProvider? localProvider;
  AppConfigProvider? appConfigProvider ;
  AppLocalizations? local ;
  Size? mediaQuery;

}