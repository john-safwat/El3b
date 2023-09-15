import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Intro/IntroNavigator.dart';
import 'package:El3b/Presentation/UI/Intro/IntroViewModel.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroView extends StatefulWidget {
  static const String routeName = "Intro";
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends BaseState<IntroView , IntroViewModel> implements IntroNavigator{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // pick Your Language
          PageViewModel(
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                bodyTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),
                imageFlex: 2,
                titlePadding: const EdgeInsets.all(20),
                bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
                imagePadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              title: viewModel!.local!.yourLanguage,
              // title: "Welcome",
              bodyWidget: const LanguageSwitch(),
              image: Lottie.asset("Assets/Animations/language.json")
          ) ,
          // Welcome Message
          PageViewModel(
            decoration: PageDecoration(
              titleTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),
              bodyTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 20
              ),
              imageFlex: 2,
              titlePadding: const EdgeInsets.all(20),
              bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
              imagePadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            title: viewModel!.local!.welcome,
            // title: "Welcome",
            body: viewModel!.local!.welcomeToEl3b,
            image: Lottie.asset("Assets/Animations/hello.json")

          ) ,
          // Gaming Nights
          PageViewModel(
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                bodyTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),
                imageFlex: 2,
                titlePadding: const EdgeInsets.all(20),
                bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
                imagePadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              title: viewModel!.local!.gamingNights,
              // title: "Welcome",
              body: viewModel!.local!.letUsHelpYou,
              image: Lottie.asset("Assets/Animations/gaming.json")
          ) ,
          // You Are Not Alone
          PageViewModel(
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                bodyTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),
                imageFlex: 2,
                titlePadding: const EdgeInsets.all(20),
                bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
                imagePadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              title: viewModel!.local!.youAreNotAlone,
              // title: "Welcome",
              body: viewModel!.local!.chatWithOtherPlayers,
              image: Lottie.asset("Assets/Animations/chat.json")
          ) ,
          // Giveaway
          PageViewModel(
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                bodyTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),
                imageFlex: 2,
                titlePadding: const EdgeInsets.all(20),
                bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
                imagePadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              title: viewModel!.local!.giveaway,
              // title: "Welcome",
              body: viewModel!.local!.everyDayWeHaveGiveaways,
              image: Lottie.asset("Assets/Animations/giveaway.json")
          ) ,
          // Who Are You
          PageViewModel(
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                bodyTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),
                imageFlex: 2,
                titlePadding: const EdgeInsets.all(20),
                bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
                imagePadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              title: viewModel!.local!.whoAreYou,
              // title: "Welcome",
              body: viewModel!.local!.letUsKnowWhoYouAre,
              image: Lottie.asset("Assets/Animations/login.json")
          ) ,
        ],
        done: Text(viewModel!.local!.finish),
        next: Text(viewModel!.local!.next),
        back: Text(viewModel!.local!.back),
        backStyle: ButtonStyle(
            textStyle: MaterialStateProperty.all( const TextStyle(color: MyTheme.offWhite, fontSize: 18)),
            foregroundColor: MaterialStateProperty.all(MyTheme.offWhite)
        ) ,
        nextStyle:  ButtonStyle(
          textStyle: MaterialStateProperty.all( const TextStyle(color: MyTheme.offWhite, fontSize: 18)),
          foregroundColor: MaterialStateProperty.all(MyTheme.offWhite)
        ),
        doneStyle: ButtonStyle(
            textStyle: MaterialStateProperty.all( const TextStyle(color: MyTheme.offWhite, fontSize: 18)),
            foregroundColor: MaterialStateProperty.all(MyTheme.offWhite)
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: MyTheme.lightPurple,
          color: MyTheme.offWhite,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
          ),
        ),
        showBackButton: true,
        onDone: viewModel!.onDonePress,
      ),
    );
  }

  @override
  IntroViewModel initViewModel() {
    return IntroViewModel();
  }

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
