import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:El3b/Presentation/UI/Splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Home/HomeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider(),),
          ChangeNotifierProvider(create: (context) => LocalProvider(),),
          ChangeNotifierProvider(create: (context) => AppConfigProvider(),)
        ],
        child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  late ThemeProvider themeProvider ;
  late LocalProvider localProvider ;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    localProvider = Provider.of<LocalProvider>(context);
    setTheme();
    setLocal();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates:const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale:Locale(localProvider.currentLocal),
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        SplashScreen.routeName :(_) => SplashScreen(),
        LoginView.routeName :(_) => LoginView(),
        HomeScreen.routeName : (_) => HomeScreen()
      },
      initialRoute: SplashScreen.routeName,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: themeProvider.theme,
    );
  }

  Future<void> setTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString("theme");
    themeProvider.changeTheme(theme == "Dark" || theme == null? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setLocal()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var local = prefs.getString("local");
    localProvider.changeLocal(local??="en");
  }
}