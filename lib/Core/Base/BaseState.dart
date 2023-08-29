import 'package:El3b/Core/Base/BaseNavigator.dart';
import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


abstract class BaseState< T extends StatefulWidget , VM extends BaseViewModel> extends State<T> implements BaseNavigator{
  VM? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel!.navigator = this;
    viewModel!.appConfigProvider = Provider.of<AppConfigProvider>(context , listen: false);
    viewModel!.themeProvider = Provider.of<ThemeProvider>(context , listen: false);
    viewModel!.localProvider = Provider.of<LocalProvider>(context , listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel!.navigator = null ;
    viewModel!.appConfigProvider = null;
    viewModel!.themeProvider = null ;
    viewModel!.localProvider =null;
    viewModel =null;
  }

  VM initViewModel();


}
