import 'package:core/Providers/ThemeProvider.dart';
import 'package:core/Theme/Theme.dart';
import 'package:presentation/UI/Home/HomeView.dart';
import 'package:presentation/UI/Intro/IntroView.dart';
import 'package:presentation/UI/Login/LoginView.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "SplashScreen";

  bool firstTime;

  bool loggedIn;

  User? user;

  SplashScreen(
      {required this.firstTime, required this.loggedIn, this.user, super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedSplashScreen(
      splash: Center(
        child: SizedBox(
          height: 300,
          child: themeProvider.isDark()
              ? Image.asset(
                  "Assets/Images/DarkLogo.png",
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "Assets/Images/LightLogo.png",
                  fit: BoxFit.cover,
                ),
        ),
      ),
      nextScreen: firstTime
          ? const IntroView()
          : user != null && loggedIn
              ? const HomeView()
              : const LoginView(),
      duration: 2000,
      backgroundColor:
          themeProvider.isDark() ? MyTheme.darkPurple : MyTheme.offWhite,
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
