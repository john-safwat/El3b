
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Home/HomeView.dart';
import 'package:El3b/Presentation/UI/Intro/IntroView.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "SplashScreen";

  bool firstTime ;
  bool loggedIn ;
  User? user;

  SplashScreen({required this.firstTime ,required this.loggedIn, this.user ,super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDark()? MyTheme.offWhite : MyTheme.purple,
      body: Column(
        children: [
          Expanded(
            flex: 2,
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:const BorderRadius.only(
                          topRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                        ),
                      ),
                      child: Center(
                        child: Animate(
                          effects: const [ScaleEffect(duration: Duration(milliseconds: 500))],
                          child: SvgPicture.asset("Assets/SVG/sparkles.svg"),
                        ).rotate(duration: const Duration(milliseconds: 700)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(60),
                          )
                      ),
                    ),
                  )
                ],
              )
          ),
          Expanded(
            flex: 3,
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60)
                          ),
                        ),
                      child: AnimatedSplashScreen(
                        splash: Center(
                          child: SizedBox(
                            height: 300,
                            child: themeProvider.isDark()
                                ? Image.asset("Assets/Images/DarkLogo.png" , fit: BoxFit.cover,)
                                : Image.asset("Assets/Images/LightLogo.png" , fit: BoxFit.cover,),
                          ),
                        ),
                        nextScreen:firstTime? const IntroView(): user != null && loggedIn?const HomeView(): const LoginView(),
                        duration: 2000,
                        backgroundColor: Colors.transparent,
                        splashIconSize: double.infinity,
                        splashTransition: SplashTransition.scaleTransition,

                      ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
            flex: 2,
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:const BorderRadius.only(
                          bottomRight: Radius.circular(60)
                        ),
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius:const BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            topRight: Radius.circular(60)
                          )
                      ),
                      child: Center(
                        child: Animate(
                          effects: const [RotateEffect(duration: Duration(milliseconds: 500))],
                          child: SvgPicture.asset("Assets/SVG/sparkles.svg"),
                        ).scale(duration: const Duration(milliseconds: 700)),
                      ),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
