import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = "HomeScreenView";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var localProvider = Provider.of<LocalProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          themeProvider.isDark()
              ? Image.asset("Assets/Images/DarkLogo.png" , fit: BoxFit.cover,)
              : Image.asset("Assets/Images/LightLogo.png" , fit: BoxFit.cover,),
          ElevatedButton(
            onPressed: ()async{
              await themeProvider.changeTheme(ThemeMode.light);
            },
            child: Text(AppLocalizations.of(context)!.makeThemeLight)
          ), ElevatedButton(
            onPressed: ()async{
              await themeProvider.changeTheme( ThemeMode.dark);
            },
            child: Text(AppLocalizations.of(context)!.makeThemeDark)
          ),
          ElevatedButton(
              onPressed: ()async{
                await localProvider.changeLocal("ar");
              },
              child: Text("ar")
          ), ElevatedButton(
              onPressed: ()async{
                await localProvider.changeLocal("en");
              },
              child: Text('en')
          )
        ],
      ),
    );
  }
}
