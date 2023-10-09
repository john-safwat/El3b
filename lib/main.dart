import 'package:El3b/Core/Providers/AppConfigProvider.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Presentation/UI/About/AboutView.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileView.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoView.dart';
import 'package:El3b/Presentation/UI/Feedback/FeedbackView.dart';
import 'package:El3b/Presentation/UI/ForgetPassword/ForgetPasswordView.dart';
import 'package:El3b/Presentation/UI/GamesList/GamesListView.dart';
import 'package:El3b/Presentation/UI/GamesSearch/GameSearchView.dart';
import 'package:El3b/Presentation/UI/History/HistoryView.dart';
import 'package:El3b/Presentation/UI/Intro/IntroView.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:El3b/Presentation/UI/Register/RegisterView.dart';
import 'package:El3b/Presentation/UI/Splash/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Home/HomeView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async{
  // block the code building for the loading of data
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // call shared pref to get some value
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var firstTime = prefs.getBool("firstTime");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // validate on current user
  var user = FirebaseAuth.instance.currentUser;
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider(),),
          ChangeNotifierProvider(create: (context) => LocalProvider(),),
          ChangeNotifierProvider(create: (context) => AppConfigProvider(),)
        ],
        child: MyApp(firstTime: firstTime?? true, user: user,)
      )
  );
}

class MyApp extends StatelessWidget {
  bool firstTime;
  User? user;
  MyApp({required this.firstTime , this.user});

  late ThemeProvider themeProvider ;
  late LocalProvider localProvider ;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    localProvider = Provider.of<LocalProvider>(context);
    setTheme();
    setLocal();

    if(user != null){
      var provider = Provider.of<AppConfigProvider>(context , listen: false);
      provider.updateUserWithoutNotifyListeners(user: user!);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates:const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale:Locale(localProvider.getLocal()),
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        SplashScreen.routeName : (_) => SplashScreen(firstTime: firstTime , user: user),
        IntroView.routeName : (_) => const IntroView(),
        LoginView.routeName : (_) => const LoginView(),
        HomeView.routeName : (_) => const HomeView(),
        RegisterView.routeName : (_) => const RegisterView(),
        ExtraInfoView.routeName : (_) => const ExtraInfoView(),
        ForgetPasswordView.routeName : (_) => const ForgetPasswordView(),
        GameSearchView.routeName :(_)=> const GameSearchView(),
        GamesListView.routeName :(_)=> const GamesListView(),
        EditProfileView.routeName : (_) => const EditProfileView(),
        HistoryView.routeName :(_) => const HistoryView(),
        FeedbackView.routeName :(_) => const FeedbackView(),
        AboutView.routeName :(_) => const AboutView()
      },
      initialRoute: SplashScreen.routeName,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: themeProvider.getTheme(),
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