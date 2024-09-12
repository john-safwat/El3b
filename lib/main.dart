import 'package:core/Providers/app_config_provider.dart';
import 'package:core/Providers/local_provider.dart';
import 'package:core/Providers/theme_provider.dart';
import 'package:core/Theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presentation/UI/About/AboutView.dart';
import 'package:presentation/UI/CreateRoom/CreateRoomView.dart';
import 'package:presentation/UI/EditProfile/EditProfileView.dart';
import 'package:presentation/UI/ExtraInfo/ExtraInfoView.dart';
import 'package:presentation/UI/Feedback/FeedbackView.dart';
import 'package:presentation/UI/ForgetPassword/ForgetPasswordView.dart';
import 'package:presentation/UI/GamesList/GamesListView.dart';
import 'package:presentation/UI/GamesSearch/GameSearchView.dart';
import 'package:presentation/UI/History/HistoryView.dart';
import 'package:presentation/UI/Home/HomeView.dart';
import 'package:presentation/UI/Intro/IntroView.dart';
import 'package:presentation/UI/Login/LoginView.dart';
import 'package:presentation/UI/Register/RegisterView.dart';
import 'package:presentation/UI/ResetPassword/ResetPasswordView.dart';
import 'package:presentation/UI/Splash/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main()async{
  // block the code building for the loading of data
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // call shared pref to get some value
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var firstTime = prefs.getBool("firstTime");
  var loggedIn = prefs.getBool("loggedIn");

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
          ChangeNotifierProvider(create: (context) => AppConfigProvider(user: user),)
        ],
        child: MyApp(firstTime: firstTime?? true , loggedIn: loggedIn??false, user: user,)
      )
  );
}

class MyApp extends StatelessWidget {
  bool firstTime;
  bool loggedIn ;
  User? user;
  MyApp({required this.firstTime , required this.loggedIn , this.user});

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
      locale:Locale(localProvider.getLocal()),
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        SplashScreen.routeName : (_) => SplashScreen(firstTime: firstTime, loggedIn: loggedIn, user: user),
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
        AboutView.routeName :(_) => const AboutView(),
        CreateRoomView.routeName :(_) => const CreateRoomView(),
        ResetPasswordView.routeName : (_) => const ResetPasswordView()
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