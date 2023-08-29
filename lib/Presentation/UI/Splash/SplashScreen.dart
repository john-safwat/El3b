import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Home/HomeScreen.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedSplashScreen(
      splash: Center(
        child: SizedBox(
          height: 300,
          child: themeProvider.isDark()
              ? Image.asset("Assets/Images/DarkLogo.png" , fit: BoxFit.cover,)
              : Image.asset("Assets/Images/LightLogo.png" , fit: BoxFit.cover,),
        ),
      ),
      nextScreen:const LoginView(),
      duration: 2000,
      backgroundColor: themeProvider.isDark()? MyTheme.darkPurple : MyTheme.offWhite,
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.scaleTransition,

    );
  }
}
