import 'package:core/Base/BaseState.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/UI/About/AboutNavigator.dart';
import 'package:presentation/UI/About/AboutViewModel.dart';
import 'package:presentation/UI/About/Widgets/ListPoints.dart';
import 'package:presentation/UI/About/Widgets/TextCard.dart';

class AboutView extends StatefulWidget {
  static const String routeName = "About";

  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends BaseState<AboutView, AboutViewModel>
    implements AboutNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.local!.aboutUs),
      ),
      body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                "El3b",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                viewModel.local!.aboutUsMessage1,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Image.asset("Assets/Images/aboutUs.png"),
              const SizedBox(height: 50),
              Text(
                viewModel.local!.aboutUsMessage2,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextCard(content: viewModel.local!.mainFeatures),
              const SizedBox(height: 30),
              ListPoints(content: viewModel.local!.aboutUsMessage3),
              ListPoints(content: viewModel.local!.aboutUsMessage4),
              Lottie.asset("Assets/Animations/aboutUs2.json"),
              ListPoints(content: viewModel.local!.aboutUsMessage5),
              ListPoints(content: viewModel.local!.aboutUsMessage6),
              ListPoints(content: viewModel.local!.aboutUsMessage7),
              const SizedBox(height: 10),
              Lottie.asset("Assets/Animations/aboutUs5.json"),
              const SizedBox(height: 10),
              Text(
                viewModel.local!.aboutUsMessage8,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Lottie.asset("Assets/Animations/aboutUs4.json"),
              const SizedBox(height: 30),
              TextCard(content: viewModel.local!.appVersion),
            ],
          )),
    );
  }

  @override
  AboutViewModel initViewModel() {
    return AboutViewModel();
  }
}
